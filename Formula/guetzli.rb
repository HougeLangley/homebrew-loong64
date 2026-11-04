class Guetzli < Formula
  desc "Perceptual JPEG encoder"
  homepage "https://github.com/google/guetzli"
  url "https://github.com/google/guetzli/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "e52eb417a5c0fb5a3b08a858c8d10fa797627ada5373e203c196162d6a313697"
  license "Apache-2.0"
  head "https://github.com/google/guetzli.git", branch: "master"


  deprecate! date: "2026-07-14", because: :repo_archived
  disable! date: "2027-01-14", because: :repo_archived

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ad6c61000c778f558d64770b48544a557f3037fc0538fbe70d2639c04d8aa344"
  end

  depends_on "pkgconf" => :build
  depends_on "libpng"

  def install
    system "make"
    bin.install "bin/Release/guetzli"
  end

  test do
    system bin/"guetzli", test_fixtures("test.png"), "test.jpg"
  end
end
