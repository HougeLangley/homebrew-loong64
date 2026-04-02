class Telnet < Formula
  desc "User interface to the TELNET protocol"
  homepage "https://www.gnu.org/software/inetutils/"
  url "https://ftp.gnu.org/gnu/inetutils/inetutils-2.5.tar.xz"
  sha256 "72012022d59e01e36d3114786e15b16fb73a0e7c5c42abfc7c1d2c734f5a1d2b"
  license "GPL-3.0-or-later"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"telnet", "--version"
  end
end
