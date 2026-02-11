class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.7/skybox-darwin-arm64.tar.gz"
      sha256 "90ab81f5a865fb93d8358647d224c2a9c7394adc8c84090923fd24e89f2f0b9a"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.7/skybox-darwin-x64.tar.gz"
      sha256 "ca54430ba87b7f580100d76eb1c39059e1caadc91e2d7fc4cb49a3d5cf2b456b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.7/skybox-linux-x64.tar.gz"
      sha256 "833f61416212115bc15b4538cc9fdd232fc249b63cdc53cdc1ce4771d30fec75"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.7/skybox-linux-arm64.tar.gz"
      sha256 "dc150f02985f3fcbe05499f703e14afe665136fa44f62bdff15b4946a4082a59"
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
