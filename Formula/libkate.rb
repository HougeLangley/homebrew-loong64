class Libkate < Formula
  desc "Overlay codec for multiplexed audio/video in Ogg"
  homepage "https://wiki.xiph.org/index.php/OggKate"
  url "https://downloads.xiph.org/releases/kate/libkate-0.4.3.tar.gz"
  sha256 "96827ca136ad496b4e34ff3ed2434a8e76ad83b1e6962b5df06ad24cbbfeebaf"
  license "BSD-3-Clause"


  head do
    url "https://gitlab.xiph.org/xiph/kate.git", branch: "main"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    uses_from_macos "bison" => :build
    uses_from_macos "flex" => :build
  end

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2a5a007b9c506058a83d25af2fd70f4f7dbc408a418d90a8fb9032d1962a483b"
  end

  depends_on "pkgconf" => :build
  depends_on "libogg"
  depends_on "libpng"

  def install
    configure = build.head? ? "./autogen.sh" : "./configure"
    system configure, "--disable-silent-rules",
                      "--enable-shared",
                      "--enable-static",
                      *std_configure_args
    system "make", "check"
    system "make", "install"

    rm(man1/"KateDJ.1")
  end

  test do
    system bin/"katedec", "-V"
  end
end
