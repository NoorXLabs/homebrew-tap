class Devbox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/DevBox"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.4.0/devbox-darwin-arm64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end

    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.4.0/devbox-darwin-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.4.0/devbox-linux-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
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
