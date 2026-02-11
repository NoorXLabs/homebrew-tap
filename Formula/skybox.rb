class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.8"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.8/skybox-darwin-arm64.tar.gz"
      sha256 "adfa049dd471a063f88ec0ee45d33b273a52a3ecaa04a0239cff2e5c23f74de6"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.8/skybox-darwin-x64.tar.gz"
      sha256 "79ecb4abed9d8e94ca738e66b2ab42967d8cd98de0828f1d1db4308547172697"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.8/skybox-linux-x64.tar.gz"
      sha256 "f7f5467a93817d50c81995a0a62f29e5df7932c63baffd91cc7548fce78dfd25"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.8/skybox-linux-arm64.tar.gz"
      sha256 "07c834bfa241502cbf68bfde526b0b8a0d74f6125b4827b1d6e400b39a254d5b"
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
