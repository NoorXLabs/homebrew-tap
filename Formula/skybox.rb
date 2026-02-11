class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.4"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.4/skybox-darwin-arm64.tar.gz"
      sha256 "ac5e18729bc944411c927e1506167bd8d066cedc5fdce1d36c0074797a615b98"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.4/skybox-darwin-x64.tar.gz"
      sha256 "2b20296c7bf03f8b238112fef015975be33ecbc83d356be3a8a9cb141e7ab2f2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.4/skybox-linux-x64.tar.gz"
      sha256 "be103f600a6604c4f16ce930513a48518ae542acd94599dc5a5d10b9da70af9e"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.4/skybox-linux-arm64.tar.gz"
      sha256 "86e3242653239e66d1ed2f27c2037025ecb38098a69421a6ead2deccde0bc19b"
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
