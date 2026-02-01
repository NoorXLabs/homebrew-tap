class Devbox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/DevBox"
  version "0.7.5"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.5/devbox-darwin-arm64.tar.gz"
      sha256 "8365785a56cdaaaa5bee9bf29dee7a5dc6ae39af0605992fa8c3632bfc8b85ee"
    end

    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.5/devbox-darwin-x64.tar.gz"
      sha256 "42c1029018e974cc2bb8f4dde2119d7dcad502b23dd02d11dd4309247d91448a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.5/devbox-linux-x64.tar.gz"
      sha256 "5efe065e35bfd88611970131cd6a3c1289e6b6332dde19417d77df9c004a3d73"
    end

    on_arm do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.5/devbox-linux-arm64.tar.gz"
      sha256 "8761eff3784b73f9c425a478f2a571c4fd0198a6efeb6e6910efb224115dfc9e"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "devbox-darwin-arm64" => "devbox"
    elsif OS.mac? && Hardware::CPU.intel?
      bin.install "devbox-darwin-x64" => "devbox"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "devbox-linux-x64" => "devbox"
    elsif OS.linux? && Hardware::CPU.arm?
      bin.install "devbox-linux-arm64" => "devbox"
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
