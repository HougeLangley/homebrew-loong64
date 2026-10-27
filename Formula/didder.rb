class Didder < Formula
  desc "An extensive, fast, and accurate command-line image dithering tool."
  homepage "https://example.org/didder"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/didder--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "3f13756e6bc26017638f7a3a88ac1b2e94eae88e5202dd5e3dd5484ce5b3a2e5"

  def install
    bin.install "didder"
  end

  test do
    system "#{bin}/didder"
  end
end
