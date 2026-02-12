class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.9/skybox-darwin-arm64.tar.gz"
      sha256 "20f0e9c6bc41889087dff86d56f15f43ff7b9400e710f1fc82cc934a70b2511d"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.9/skybox-darwin-x64.tar.gz"
      sha256 "6e3e260d9d6808249009a1a712e19fb6082812050cbd5bffc731fecb2df544e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.9/skybox-linux-x64.tar.gz"
      sha256 "ccedfbe09803a122e9a7a54a3dc66f4b7b95debb37e174cb24ce08dd9d49a0d5"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.9/skybox-linux-arm64.tar.gz"
      sha256 "90bc05405825e01872d97e7cd6aba0f87a80db8491190eec52e71a8d3de89c0d"
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
