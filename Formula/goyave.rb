class Goyave < Formula
  desc "🍐 The enterprise REST API framework"
  homepage "https://example.org/goyave"
  version "5.12.6"
  url "http://127.0.0.1:8080/brew/bottles/goyave--5.12.6.loongarch64.bottle.tar.gz"
  sha256 "5c59101ad4df9f2a351512ae05ad8a3536892aa1e0ad95551e767802108286f0"

  def install
    bin.install "goyave"
  end

  test do
    system "#{bin}/goyave"
  end
end
