class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.0/skybox-darwin-arm64.tar.gz"
      sha256 "24005ffcae65c221d75fef3cebe9b672514bd44b923004c7f3301ba0fa9f8666"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.0/skybox-darwin-x64.tar.gz"
      sha256 "b4018bedb2984b7546730d331c9b02390578af30c6d5f4b826433fb293599a6c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.0/skybox-linux-x64.tar.gz"
      sha256 "99a2de3dca8e0fc82a59be837ab6ae67bcf028cc35382531323ebcc9fac80d57"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.0/skybox-linux-arm64.tar.gz"
      sha256 "02c7cefa65b49a65ef5b749d2567a884c7b7dd8c34b7a7495dae023508a0f91f"
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
