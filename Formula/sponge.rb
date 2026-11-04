class Sponge < Formula
  desc "Soak up standard input and write to a file"
  homepage "https://joeyh.name/code/moreutils/"
  url "https://deb.debian.org/debian/pool/main/m/moreutils/moreutils_0.70.orig.tar.xz"
  sha256 "a844c5e3360a73d12c0a5624750ecc1969d64afea2e84925328f137576e2eb55"
  license "GPL-2.0-only"
  head "https://git.joeyh.name/git/moreutils.git", branch: "master"

  livecheck do
    formula "moreutils"
  end


  conflicts_with "moreutils", because: "both install a `sponge` executable"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "278deea6b05d1dcb11edbde1f102bcd43c3320cabc55ad9823262d7d512b0acd"
  end

  def install
    system "make", "sponge"
    bin.install "sponge"
  end

  test do
    file = testpath/"sponge-test.txt"
    file.write("c\nb\na\n")
    system "sort #{file} | #{bin/"sponge"} #{file}"
    assert_equal "a\nb\nc\n", File.read(file)
  end
end
