class Afl++ < Formula
  desc "American Fuzzy Lop++"
  homepage "https://example.org/afl++"
  version "5.03c"
  url "http://127.0.0.1:8080/brew/bottles/afl++--5.03c.loongarch64.bottle.tar.gz"
  sha256 "0025928cafc10415e4aea447d7ab45c4c4ad78a64657bda0e767738ca68931a8"

  def install
    bin.install "afl++"
  end

  test do
    system "#{bin}/afl++"
  end
end
