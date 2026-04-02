class Bc < Formula
  desc "Arbitrary precision numeric processing language"
  homepage "https://www.gnu.org/software/bc/"
  url "https://ftp.gnu.org/gnu/bc/bc-1.07.1.tar.gz"
  sha256 "62adfca89b0a1c0164c2cdca59ca210c1d44c3ffc5da201bd239519afae4e607"
  license "GPL-3.0-or-later"

  depends_on "ed"
  depends_on "texinfo"

  def install
    system "./configure",
           "--prefix=#{prefix}",
           "--infodir=#{info}",
           "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system bin/"bc", "--version"
  end
end
