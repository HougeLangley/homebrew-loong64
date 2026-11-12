class Zboy < Formula
  desc "GameBoy emulator"
  homepage "https://zboy.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/zboy/zBoy%20v0.71/zboy-0.71.tar.xz"
  sha256 "d359b87e3149418fbe1599247c9ca71e870d213b64a912616ffc6e77d1dff506"
  license "GPL-3.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e3795b120dfc60b9b9b7dd47fdc815e089c77883bb4b0dbbf577b1b5ec690738"
  end

  head "https://svn.code.sf.net/p/zboy/code/trunk"

  livecheck do
    url :stable
    regex(%r{url=.*?/zboy[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end



  depends_on "sdl2-compat"

  deny_network_access!

  def install
    system "make", "-f", "Makefile.linux"
    bin.install "zboy"
  end

  test do
    system bin/"zboy", "--help"
  end
end
