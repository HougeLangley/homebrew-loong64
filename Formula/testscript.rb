class Testscript < Formula
  desc "Integration tests for command-line applications in .txtar format"
  homepage "https://example.org/testscript"
  version "1.15.0"
  url "http://127.0.0.1:8080/brew/bottles/testscript--1.15.0.loongarch64.bottle.tar.gz"
  sha256 "5586ade8a63150f481bb1215c92659a52391353921f7a0851f4fdc5a11cd920d"

  def install
    bin.install "testscript"
  end

  test do
    system "#{bin}/testscript"
  end
end
