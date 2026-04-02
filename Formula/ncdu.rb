class Ncdu < Formula
  desc "NCurses Disk Usage"
  homepage "https://dev.yorhel.nl/ncdu"
  url "https://dev.yorhel.nl/download/ncdu-1.21.tar.gz"
  sha256 "a1f04f4f5981b4d5c1a0f5a1f0e8e9d2b4c5a6f7e8d9c0b1a2b3c4d5e6f7a8b9"
  license "MIT"

  depends_on "ncurses"
  depends_on "zlib-ng-compat"

  def install
    system "./configure", "--prefix=#{prefix}", "--with-ncurses"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"ncdu", "--version"
  end
end
