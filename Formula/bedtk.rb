class Bedtk < Formula
  desc "Simple toolset for BED files"
  homepage "https://github.com/lh3/bedtk"
  url "https://github.com/lh3/bedtk/archive/refs/tags/v1.2.tar.gz"
  sha256 "c0e1f454337dbd531659662ccce6c35831e7eec75ddf7b7751390b869e6ce9f0"
  license "MIT"


  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "94601e5d0c79ac2762e5e4bfc30cf795c58d03b0d620e7523e38dcf2322df15b"
  end

  def install
    system "make"
    bin.install "bedtk"
    pkgshare.install "test"
  end

  test do
    cp_r pkgshare/"test/.", testpath
    system bin/"bedtk", "flt", "test-anno.bed.gz", "test-iso.bed.gz"
  end
end
