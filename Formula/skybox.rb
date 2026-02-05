class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.4.0/skybox-darwin-arm64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.4.0/skybox-darwin-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.4.0/skybox-linux-x64.tar.gz"
      sha256 "REPLACE_WITH_ACTUAL_SHA256"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "skybox-darwin-arm64" => "skybox"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "skybox-darwin-x64" => "skybox"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "skybox-linux-x64" => "skybox"
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
