class Devbox < Formula
  desc "Local-first development container manager"
  homepage "https://github.com/NoorXLabs/DevBox"
  version "0.7.7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.7/devbox-darwin-arm64.tar.gz"
      sha256 "9b7cdaaeb5640fe94f5a4c95ee5ebcafb7d1f376e55df16923b56f42cd5b0406"
    end

    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.7/devbox-darwin-x64.tar.gz"
      sha256 "a606660731108a4f0266e21314af69082c27fb9c4f36edc25db6f31143933731"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.7/devbox-linux-x64.tar.gz"
      sha256 "27ff2f818366e639b5b6408514c7ad6757458e04f7b42dde7b0b7f76482e65eb"
    end

    on_arm do
      url "https://github.com/NoorXLabs/DevBox/releases/download/v0.7.7/devbox-linux-arm64.tar.gz"
      sha256 "be277bc0d4d0695432e9119b08c2ad57b5959bdb3bd4743655e962397f9cb83a"
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
