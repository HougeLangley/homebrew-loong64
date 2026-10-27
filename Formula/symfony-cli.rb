class Symfony-cli < Formula
  desc "Build, run, and manage Symfony applications"
  homepage "https://example.org/symfony-cli"
  version "5.22.2"
  url "http://127.0.0.1:8080/brew/bottles/symfony-cli--5.22.2.loongarch64.bottle.tar.gz"
  sha256 "18003dca9e498f0d8e51a56f290ddbd9feee4f7d6890e5a05869f35b6bd02a07"

  def install
    bin.install "symfony-cli"
  end

  test do
    system "#{bin}/symfony-cli"
  end
end
