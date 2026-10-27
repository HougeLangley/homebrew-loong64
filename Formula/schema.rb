class Schema < Formula
  desc "Package gorilla/schema fills a struct with form values."
  homepage "https://example.org/schema"
  version "1.4.1"
  url "http://127.0.0.1:8080/brew/bottles/schema--1.4.1.loongarch64.bottle.tar.gz"
  sha256 "40ccdb1e1d707ece35f7308b5fc5f776be79433aa8b95f4b35072a307a675aae"

  def install
    bin.install "schema"
  end

  test do
    system "#{bin}/schema"
  end
end
