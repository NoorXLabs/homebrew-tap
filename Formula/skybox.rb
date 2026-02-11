class Skybox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/SkyBox"
  version "0.8.1"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.1/skybox-darwin-arm64.tar.gz"
      sha256 "91ac51cf25bce7fb64e324f6de3b59f197626a51e2aafc0284865fc0f430c777"
    end

    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.1/skybox-darwin-x64.tar.gz"
      sha256 "8dbd791055966728d1d25293aeae52ab041956ed6ebd93fc1b59cfc0d8104230"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.1/skybox-linux-x64.tar.gz"
      sha256 "7ac69409f2d9818266254743952276db59372e50f547740fa54a9fe7fa6b9aa1"
    end

    on_arm do
      url "https://github.com/NoorXLabs/SkyBox/releases/download/v0.8.1/skybox-linux-arm64.tar.gz"
      sha256 "a962bf97e88e6ef322ea26b004a9f2ac755db714d5b1828bf26111ffe2274d61"
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
