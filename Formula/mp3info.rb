class Mp3info < Formula
  desc "MP3 technical info viewer and ID3 1.x tag editor"
  homepage "https://www.ibiblio.org/mp3info/"
  url "https://www.ibiblio.org/pub/linux/apps/sound/mp3-utils/mp3info/mp3info-0.8.5a.tgz"
  sha256 "0438ac68e9f04947fb14ca5573d27c62454cb9db3a93b7f1d2c226cd3e0b4e10"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://www.ibiblio.org/pub/linux/apps/sound/mp3-utils/mp3info/"
    regex(/href=.*?mp3info[._-]v?(\d+(?:\.\d+)+(?:[._-]?[a-z]\d*)?)\.(t|zip)/i)
  end


  uses_from_macos "ncurses"

  patch :p0 do
    file "Patches/mp3info/patch-mp3tech.c.diff"
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5003f2f2c0c471d88fa37d6c97dd7b830add3954c506f4df5768553c9d193deb"
  end

  def install
    system "make", "mp3info", "doc"
    bin.install "mp3info"
    man1.install "mp3info.1"
  end

  test do
    system bin/"mp3info", "-x", test_fixtures("test.mp3")
  end
end
