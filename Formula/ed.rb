class Ed < Formula
  desc "Classic UNIX line editor"
  homepage "https://www.gnu.org/software/ed/"
  url "https://ftp.gnu.org/gnu/ed/ed-1.20.2.tar.lz"
  sha256 "65fec7314fb4d6eb0d4d3f94beee5cd4b73c7c156954010d46673e1424c041f7"
  license "GPL-3.0-or-later"

  def install
    system "./configure", "--prefix=#{prefix}", "--program-prefix=g"
    system "make", "install"
  end

  test do
    system bin/"ged", "--version"
  end
end
