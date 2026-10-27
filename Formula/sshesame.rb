class Sshesame < Formula
  desc "An easy to set up and use SSH honeypot, a fake SSH server that lets anyone in and logs the"
  homepage "https://example.org/sshesame"
  version "0.0.39"
  url "http://127.0.0.1:8080/brew/bottles/sshesame--0.0.39.loongarch64.bottle.tar.gz"
  sha256 "918d5747b019cd54f896237a4e5cf8a9b62d9f17ddc3425359e75018ee9275c4"

  def install
    bin.install "sshesame"
  end

  test do
    system "#{bin}/sshesame"
  end
end
