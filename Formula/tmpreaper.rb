class Tmpreaper < Formula
  desc "Clean up files in directories based on their age"
  homepage "https://packages.debian.org/sid/tmpreaper"
  url "https://ftp.debian.org/debian/pool/main/t/tmpreaper/tmpreaper_1.6.18.tar.xz"
  sha256 "2ae7de0775b49abd222d09ad71360d795b40aa7c31253363e64c182966a37c00"
  license "GPL-2.0-only"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "22e33b127657fa88e448506105a004d4c8cac3dbf2dc755c09e904f599e6f38d"
  end

  livecheck do
    url "https://deb.debian.org/debian/pool/main/t/tmpreaper/"
    regex(/href=.*?tmpreaper[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build

  on_linux do
    depends_on "e2fsprogs"
    depends_on "util-linux"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make", "install"
  end

  test do
    touch "removed"
    sleep 3
    touch "not-removed"
    system sbin/"tmpreaper", "2s", "."
    refute_path_exists testpath/"removed"
    assert_path_exists testpath/"not-removed"
  end
end
