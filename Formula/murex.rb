class Murex < Formula
  desc "A smarter shell and scripting environment with advanced features designed for usability, s"
  homepage "https://example.org/murex"
  version "7.3.1232"
  url "http://127.0.0.1:8080/brew/bottles/murex--7.3.1232.loongarch64.bottle.tar.gz"
  sha256 "cb2e77927b395c067846051d6e3ada776812fe98c1370e7cd4f60aeedddcb71c"

  def install
    bin.install "murex"
  end

  test do
    system "#{bin}/murex"
  end
end
