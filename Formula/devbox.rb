class Devbox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/DevBox"
  version "0.7.2"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.2/devbox-darwin-arm64.tar.gz"
      sha256 "7dd0192af9a8723bf18363cbeeb116594c71a51dab8a9dae40cc9d450438f0f5"
    end

    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.2/devbox-darwin-x64.tar.gz"
      sha256 "a060500260b3e498d9db78f4f47b31545f128cc5c5214e413d1e66e2b43eb8e7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.2/devbox-linux-x64.tar.gz"
      sha256 "5db67066e89a50dab97de2bca05324712f2a0f015d3d221e429d1c68f417a51c"
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
