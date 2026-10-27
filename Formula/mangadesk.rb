class Mangadesk < Formula
  desc "Terminal client for MangaDex 📖"
  homepage "https://example.org/mangadesk"
  version "0.7.8"
  url "http://127.0.0.1:8080/brew/bottles/mangadesk--0.7.8.loongarch64.bottle.tar.gz"
  sha256 "b9dd5c8746137ee352c81836cce76639373e45410940510e4c8da1543046fe03"

  def install
    bin.install "mangadesk"
  end

  test do
    system "#{bin}/mangadesk"
  end
end
