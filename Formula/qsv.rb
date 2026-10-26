class Qsv < Formula
  desc "CSV toolkit"
  homepage "https://example.org/qsv"
  version "26.0.0"
  url "http://127.0.0.1:8080/brew/bottles/qsv--26.0.0.loongarch64.bottle.tar.gz"
  sha256 "5c2d7d6e111b4d56926a0d560d01262e7ef5bd5a73f4052ca97982c9b0031eb6"

  def install
    bin.install "qsv"
  end

  test do
    system "#{bin}/qsv"
  end
end
