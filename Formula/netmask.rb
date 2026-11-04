class Netmask < Formula
  desc "IP address netmask generation utility"
  homepage "https://github.com/tlby/netmask"
  url "https://github.com/tlby/netmask/releases/download/v2.5.0/netmask-2.5.0.tar.gz"
  sha256 "5975a37fb84ca7035050e10a10fe48322d8ce184b83bc8482f3f3b49882f4c73"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bece7d6987d5788c4b75ce1f2777edd2b8f161e62d2547efaafe9a556230dc89"
  end

  depends_on "pkgconf" => :build

  depends_on "check"

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    assert_equal "100.64.0.0/10", shell_output("#{bin}/netmask -c 100.64.0.0:100.127.255.255").strip
  end
end
