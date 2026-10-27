class Epicenv < Formula
  desc "An epic environment manager to fix local environment variable management among git collabo"
  homepage "https://example.org/epicenv"
  version "0.8.3"
  url "http://127.0.0.1:8080/brew/bottles/epicenv--0.8.3.loongarch64.bottle.tar.gz"
  sha256 "043186693a99b10e2d8a34aa3f9f74fd0d5e5f9ae60afc1803d74312bc305b8c"

  def install
    bin.install "epicenv"
  end

  test do
    system "#{bin}/epicenv"
  end
end
