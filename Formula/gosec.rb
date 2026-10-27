class Gosec < Formula
  desc "Go security checker"
  homepage "https://example.org/gosec"
  version "2.30.0"
  url "http://127.0.0.1:8080/brew/bottles/gosec--2.30.0.loongarch64.bottle.tar.gz"
  sha256 "67ad93aa0af8a6ebb2368921de02d092f94ef14dff5a75ea45e46786d53d5004"

  def install
    bin.install "gosec"
  end

  test do
    system "#{bin}/gosec"
  end
end
