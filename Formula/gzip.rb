class Gzip < Formula
  desc "Popular GNU data compression program"
  homepage "https://www.gnu.org/software/gzip/"
  url "https://ftp.gnu.org/gnu/gzip/gzip-1.13.tar.xz"
  sha256 "7454eb6935db17c6655576c2e1b0fabefd38b4d0376b0f16e04946bc06f8c50e"
  license "GPL-3.0-or-later"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system bin/"gzip", "--version"
  end
end
