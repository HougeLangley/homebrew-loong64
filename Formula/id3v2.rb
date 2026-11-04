class Id3v2 < Formula
  desc "Command-line editor"
  homepage "https://id3v2.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/id3v2/id3v2/0.1.12/id3v2-0.1.12.tar.gz"
  sha256 "8105fad3189dbb0e4cb381862b4fa18744233c3bbe6def6f81ff64f5101722bf"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bdd9c674bcdf8555f7db475474eea8f8effb05badaf5a64070101586373bfe7a"
  end

  depends_on "id3lib"

  uses_from_macos "mandoc" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    # mandoc is only available since Ventura, but nroff is available for older macOS
    inreplace "Makefile", "nroff ", "mandoc " if !OS.mac? || MacOS.version >= :ventura

    # Fix linker flag order on Linux
    inreplace "Makefile", "-lz -lid3", "-lid3 -lz"

    # tarball includes a prebuilt Linux binary, which will get installed
    # by `make install` if `make clean` isn't run first
    system "make", "clean"
    bin.mkpath
    man1.mkpath
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"id3v2", "--version"
  end
end
