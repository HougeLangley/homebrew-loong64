class Pinfo < Formula
  desc "User-friendly, console-based viewer for Info documents"
  homepage "https://packages.debian.org/sid/pinfo"
  url "https://github.com/baszoetekouw/pinfo/archive/refs/tags/v0.6.13.tar.gz"
  sha256 "9dc5e848a7a86cb665a885bc5f0fdf6d09ad60e814d75e78019ae3accb42c217"
  license "GPL-2.0-only"
  revision 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f48c9b7dfb946a7b6d860ba515ba7ffd7e22274064f188b1e89c236cbec1655e"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "libtool" => :build

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext"
  end

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  def install
    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `use_manual'; pinfo-pinfo.o:(.bss+0x8): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "autoreconf", "--force", "--install"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"pinfo", "-h"
  end
end
