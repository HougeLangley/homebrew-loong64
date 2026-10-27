class Mufetch < Formula
  desc "Neofetch-style music cli"
  homepage "https://example.org/mufetch"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/mufetch--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "f17e9707d855d8478411006ef6540789dcbae55083a68aa65e0c84ee98d28b5e"

  def install
    bin.install "mufetch"
  end

  test do
    system "#{bin}/mufetch"
  end
end
