class A52dec < Formula
  desc "Library for decoding ATSC A/52 streams (AKA 'AC-3')"
  homepage "https://example.org/a52dec"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/a52dec--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "9e4c2e03ad27bf1504b29a62cb34b414394feb3dff26f9d58a68913ac5a406b2"

  def install
    bin.install "a52dec"
  end

  test do
    system "#{bin}/a52dec"
  end
end
