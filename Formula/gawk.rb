class Gawk < Formula
  desc "GNU awk utility"
  homepage "https://www.gnu.org/software/gawk/"
  url "https://ftp.gnu.org/gnu/gawk/gawk-5.3.1.tar.xz"
  sha256 "694db76415a7d63e502297d4d74f426de4355f10c9bb7289d9f0184f58f3f02f"
  license "GPL-3.0-or-later"

  depends_on "gettext"
  depends_on "mpfr"
  depends_on "readline"

  def install
    system "./configure", "--prefix=#{prefix}", "--without-libsigsegv"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"gawk", "--version"
  end
end
