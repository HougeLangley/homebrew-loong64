class Findutils < Formula
  desc "Collection of GNU find, xargs, and locate"
  homepage "https://www.gnu.org/software/findutils/"
  url "https://ftp.gnu.org/gnu/findutils/findutils-4.10.0.tar.xz"
  sha256 "1387e0b91ff78d619e48975c232759b38573cdf30a2332a19126fe947032e1d6"
  license "GPL-3.0-or-later"

  def install
    args = %W[
      --prefix=#{prefix}
      --localstatedir=#{var}/locate
      --disable-dependency-tracking
      --program-prefix=g
    ]
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"gfind", "--version"
  end
end
