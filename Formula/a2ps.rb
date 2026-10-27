class A2ps < Formula
  desc "Any-to-PostScript filter"
  homepage "https://example.org/a2ps"
  version "4.15.8"
  url "http://127.0.0.1:8080/brew/bottles/a2ps--4.15.8.loongarch64.bottle.tar.gz"
  sha256 "6219fc9df570d42631c9f2b6d19d8ce5ff6f8372ef57c67e315755bfa567647d"

  def install
    bin.install "a2ps"
  end

  test do
    system "#{bin}/a2ps"
  end
end
