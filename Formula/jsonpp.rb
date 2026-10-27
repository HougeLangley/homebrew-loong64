class Jsonpp < Formula
  desc "Command-line JSON pretty-printer"
  homepage "https://example.org/jsonpp"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/jsonpp--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "ed9bcc9971c3bd49a454dd6e176117fce16e290fe055f53e3b83bb1738187f87"

  def install
    bin.install "jsonpp"
  end

  test do
    system "#{bin}/jsonpp"
  end
end
