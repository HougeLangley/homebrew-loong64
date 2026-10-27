class Richgo < Formula
  desc "Enrich  outputs with text decorations"
  homepage "https://example.org/richgo"
  version "0.3.12"
  url "http://127.0.0.1:8080/brew/bottles/richgo--0.3.12.loongarch64.bottle.tar.gz"
  sha256 "f2ca4bad6de5b053bcdac9c007289c55df0fb5a5c29c3a29ba3c6f85cef6078b"

  def install
    bin.install "richgo"
  end

  test do
    system "#{bin}/richgo"
  end
end
