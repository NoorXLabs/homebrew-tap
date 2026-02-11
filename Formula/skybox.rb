class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.6/skybox-darwin-arm64.tar.gz"
      sha256 "8ecd1036590769f5350603acbe8697990ae07335e34fe6ba9471bef7d906fbbc"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.6/skybox-darwin-x64.tar.gz"
      sha256 "9d31995461ba8eb70ff5a3ba44e9a5bdef23e52c8a771aca3a004211daa4117e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.6/skybox-linux-x64.tar.gz"
      sha256 "5c905fa4e099da1646fa088131453d367ace2a7e19493e05a3aa50fbd6646016"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.6/skybox-linux-arm64.tar.gz"
      sha256 "6ad805b8464eac49f1fe765b888f0181a5ad2a86e779db5d54d69bd31d517e4b"
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
