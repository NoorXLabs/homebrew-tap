#!/bin/bash
set -euo pipefail

# Update DevBox Homebrew formula with SHA256 hashes from a GitHub release
#
# Usage: ./scripts/update-formula.sh <version>
# Example: ./scripts/update-formula.sh 0.4.0

VERSION="${1:-}"
if [[ -z "$VERSION" ]]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.4.0"
    exit 1
fi

REPO="NoorXLabs/DevBox"
FORMULA="Formula/devbox.rb"
TMPDIR=$(mktemp -d)

cleanup() {
    rm -rf "$TMPDIR"
}
trap cleanup EXIT

echo "Updating formula for v${VERSION}..."
echo ""

# Download and hash each artifact
declare -A SHAS

for artifact in devbox-darwin-arm64 devbox-darwin-x64 devbox-linux-x64; do
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
class Devbox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/DevBox"
  version "${VERSION}"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/devbox-darwin-arm64.tar.gz"
      sha256 "${SHAS[devbox-darwin-arm64]}"
    end

    on_intel do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/devbox-darwin-x64.tar.gz"
      sha256 "${SHAS[devbox-darwin-x64]}"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/${REPO}/releases/download/v${VERSION}/devbox-linux-x64.tar.gz"
      sha256 "${SHAS[devbox-linux-x64]}"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "devbox-darwin-arm64" => "devbox"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "devbox-darwin-x64" => "devbox"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "devbox-linux-x64" => "devbox"
    end
  end

  def caveats
    <<~EOS
      DevBox requires Docker Desktop to be running.
      Start Docker Desktop before using devbox commands.

      Get started:
        devbox init
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/devbox --version")
  end
end
EOF

echo "Done!"
echo ""
echo "Next steps:"
echo "  1. Review changes: git diff Formula/devbox.rb"
echo "  2. Commit: git add Formula/devbox.rb && git commit -m 'Update devbox to v${VERSION}'"
echo "  3. Push: git push"
