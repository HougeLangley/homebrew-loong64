class Diffnav < Formula
  desc "A git diff pager based on delta but with a file tree, à la GitHub."
  homepage "https://example.org/diffnav"
  version "0.13.0"
  url "http://127.0.0.1:8080/brew/bottles/diffnav--0.13.0.loongarch64.bottle.tar.gz"
  sha256 "5d73a0502dab33ccd51d9be09406f70fcd682e6cbece22026bad667223a44d4c"

  def install
    bin.install "diffnav"
  end

  test do
    system "#{bin}/diffnav"
  end
end
