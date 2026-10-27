class Statik < Formula
  desc "Embed files into a Go executable"
  homepage "https://example.org/statik"
  version "0.1.8"
  url "http://127.0.0.1:8080/brew/bottles/statik--0.1.8.loongarch64.bottle.tar.gz"
  sha256 "810d9d8833794207a20709dad410163856ad3f46c8a4565f9560bc740a5ac7f2"

  def install
    bin.install "statik"
  end

  test do
    system "#{bin}/statik"
  end
end
