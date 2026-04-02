class Netcat < Formula
  desc "Utility for managing network connections"
  homepage "https://netcat.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.bz2"
  sha256 "b55af0bbdf5acc02d1eb6ab18e8732cb4c7f6b3ff0e5e850d618c3f494d6d8b6"
  license "GPL-2.0-or-later"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-debug"
    system "make", "install"
  end

  test do
    system bin/"netcat", "--version"
  end
end
