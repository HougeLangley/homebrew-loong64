class Svu < Formula
  desc "Semantic version utility"
  homepage "https://example.org/svu"
  version "3.4.1"
  url "http://127.0.0.1:8080/brew/bottles/svu--3.4.1.loongarch64.bottle.tar.gz"
  sha256 "92581fee090d1f59e8ca6adbd50f3ebf9697d452dac5c2833b04ed5ecbba3ba6"

  def install
    bin.install "svu"
  end

  test do
    system "#{bin}/svu"
  end
end
