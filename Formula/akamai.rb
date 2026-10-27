class Akamai < Formula
  desc "CLI toolkit for working with Akamai's APIs"
  homepage "https://example.org/akamai"
  version "2.0.5"
  url "http://127.0.0.1:8080/brew/bottles/akamai--2.0.5.loongarch64.bottle.tar.gz"
  sha256 "badec1865237c3d0294ed68965a2cd812a9078fb4ac68ea6ae40126aea473bb8"

  def install
    bin.install "akamai"
  end

  test do
    system "#{bin}/akamai"
  end
end
