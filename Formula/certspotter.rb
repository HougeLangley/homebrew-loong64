class Certspotter < Formula
  desc "Lightweight Certificate Transparency Log Monitor"
  homepage "https://example.org/certspotter"
  version "0.26.0"
  url "http://127.0.0.1:8080/brew/bottles/certspotter--0.26.0.loongarch64.bottle.tar.gz"
  sha256 "f0a3761d37986a631ae51b275f4017b3f4beaab468b80f420a26482b682cfb4a"

  def install
    bin.install "certspotter"
  end

  test do
    system "#{bin}/certspotter"
  end
end
