class Intltool < Formula
  desc "String tool"
  homepage "https://wiki.freedesktop.org/www/Software/intltool"
  url "https://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz"
  sha256 "67c74d94196b153b774ab9f89b2fa6c6ba79352407037c8c14d5aeb334e959cd"
  license "GPL-2.0-or-later"
  revision 2


  uses_from_macos "perl"

  on_linux do
    depends_on "perl-xml-parser"
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a4a4d7d5b9d34e65a4af8a3a2c6b20be0935eb76914ae2c93ae5ff5a9323085c"
  end

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"intltool-extract", "--help"
  end
end
