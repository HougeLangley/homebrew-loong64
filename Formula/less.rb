class Less < Formula
  desc "Pager program similar to more"
  homepage "https://www.greenwoodsoftware.com/less/index.html"
  url "https://www.greenwoodsoftware.com/less/less-668.tar.gz"
  sha256 "10b04fa8b572ac01975f7c4ea4278d0c858f5f5d715ad7f16a8a9dc462f5c26b"
  license "GPL-3.0-or-later"

  depends_on "ncurses"
  depends_on "pcre2"

  def install
    system "./configure", "--prefix=#{prefix}", "--with-regex=pcre2"
    system "make", "install"
  end

  test do
    system bin/"less", "--version"
  end
end
