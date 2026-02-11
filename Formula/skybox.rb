class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.5/skybox-darwin-arm64.tar.gz"
      sha256 "1fe8b551b0364ada59df0986dc67828f9112fac50ea89f60c879eadde5ca517b"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.5/skybox-darwin-x64.tar.gz"
      sha256 "fe84e08f3ad54684c2c59d6f28d0e5619fe997ed67ab4909f3e819b4683233e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.5/skybox-linux-x64.tar.gz"
      sha256 "01c91a6b701f8dfb9eaff733e4fb97121cc945c0585cda70c2e49589a8d69e25"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.5/skybox-linux-arm64.tar.gz"
      sha256 "51effe3bd8bf0253ea619c134fccd9af0c6c62da9c6fcb2f597de477f545435c"
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
