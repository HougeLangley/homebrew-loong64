class Periscope < Formula
  desc "Organize and de-duplicate your files without losing data"
  homepage "https://example.org/periscope"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/periscope--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "292896bb5ee0bd40a3bbe4ad0adac6774f191e8fed365430605b231e69f683f2"

  def install
    bin.install "periscope"
  end

  test do
    system "#{bin}/periscope"
  end
end
