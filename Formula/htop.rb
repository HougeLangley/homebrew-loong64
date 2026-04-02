class Htop < Formula
  desc "Improved top (interactive process viewer)"
  homepage "https://htop.dev/"
  url "https://github.com/htop-dev/htop/releases/download/3.4.4/htop-3.4.4.tar.xz"
  sha256 "8023f843f6b9d65b2d6cb5dbf140dc1bd18d2b73be6e8da119ca6e0e16a6f0b0"
  license "GPL-2.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"htop", "--version"
  end
end
