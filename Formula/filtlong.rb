class Filtlong < Formula
  desc "Quality filtering of long noisy DNA sequencing reads"
  homepage "https://github.com/rrwick/Filtlong"
  url "https://github.com/rrwick/Filtlong/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "09b43a0c9e2c6b40cd29e3025de8ff39302c0b5eabbf660a47c9c26bdf9dd35e"
  license "GPL-3.0-or-later"


  on_linux do
    depends_on "zlib-ng-compat"
  end

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "32c276c5036f91db4b1b504327135932b23f4ad7d615e78b0a2dfede4b531613"
  end

  def install
    system "make"
    bin.install "bin/filtlong"
    pkgshare.install "test"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/filtlong --version 2>&1")
    system bin/"filtlong", "--min_length", "1000", pkgshare/"test/test_trim.fastq"
  end
end
