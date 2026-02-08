#!/bin/bash
set -euo pipefail

# Update SkyBox Homebrew formula with SHA256 hashes from a GitHub release
#
# Usage: ./scripts/update-formula.sh <version>
# Example: ./scripts/update-formula.sh 0.8.0

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.8.0"
    exit 1
fi

REPO="NoorXLabs/SkyBox"
FORMULA="Formula/skybox.rb"
TMPDIR=$(mktemp -d)

cleanup() {
    rm -rf "$TMPDIR"
}
trap cleanup EXIT

echo "Updating formula for v${VERSION}..."
echo ""

# Download and hash each artifact
declare -A SHAS

for artifact in skybox-darwin-arm64 skybox-darwin-x64 skybox-linux-x64 skybox-linux-arm64; do
    url="https://github.com/${REPO}/releases/download/v${VERSION}/${artifact}.tar.gz"
    file="${TMPDIR}/${artifact}.tar.gz"

    echo "Downloading ${artifact}..."
    if ! curl -fsSL -o "$file" "$url"; then
        echo "Error: Failed to download ${url}"
        echo "Make sure the release v${VERSION} exists and has the artifact."
        exit 1
    fi

    sha=$(shasum -a 256 "$file" | cut -d' ' -f1)
    SHAS[$artifact]=$sha
    echo "  SHA256: ${sha}"
done

echo ""
echo "Updating ${FORMULA}..."

# Create updated formula
cat > "$FORMULA" << EOF
class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "${VERSION}"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/skybox-darwin-arm64.tar.gz"
      sha256 "${SHAS[skybox-darwin-arm64]}"
    end

    on_intel do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/skybox-darwin-x64.tar.gz"
      sha256 "${SHAS[skybox-darwin-x64]}"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/skybox-linux-x64.tar.gz"
      sha256 "${SHAS[skybox-linux-x64]}"
    end

    on_arm do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/skybox-linux-arm64.tar.gz"
      sha256 "${SHAS[skybox-linux-arm64]}"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "skybox-darwin-arm64" => "skybox"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "skybox-darwin-x64" => "skybox"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "skybox-linux-x64" => "skybox"
    elsif OS.linux? && Hardware::CPU.arm?
      bin.install "skybox-linux-arm64" => "skybox"
    end
  end

  def caveats
    <<~EOS
      SkyBox requires Docker Desktop to be running.
      Start Docker Desktop before using skybox commands.

      Get started:
        skybox init
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/skybox --version")
  end
end
EOF

echo "Done!"
echo ""
echo "Next steps:"
echo "  1. Review changes: git diff Formula/skybox.rb"
echo "  2. Commit: git add Formula/skybox.rb && git commit -m 'Update skybox to v${VERSION}'"
echo "  3. Push: git push"
