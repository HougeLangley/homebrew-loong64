class Uade < Formula
  desc "Play Amiga tunes through UAE emulation"
  homepage "https://zakalwe.fi/uade/"
  license "GPL-2.0-only"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "25a842b089382cf3493ecdf6933a6669802bb05df1b6fc35817f9f6aff90342b"
  end

  stable do
    url "https://zakalwe.fi/uade/uade3/uade-3.05.tar.bz2"
    sha256 "1a2dd9fdf8cf47c4587dcc09df16f1bb49374a9e7f8f53cdb4816d50c87e4f4c"

    resource "libzakalwe" do
      url "https://gitlab.com/hors/libzakalwe/-/archive/v1.0.0/libzakalwe-v1.0.0.tar.bz2"
      sha256 "cb503c557b04f34069654083963a056deb85a6dea25ba4b69aaaa2bbf7290a98"
    end

    resource "bencode-tools" do
      url "https://gitlab.com/heikkiorsila/bencodetools/-/archive/v1.0.1/bencodetools-v1.0.1.tar.bz2"
      sha256 "e41ae682525cf335b5f5ec0ba9b954abfe7b448e8ed13e2aa2a44e49fce2ca12"
    end
  end

  livecheck do
    url "https://zakalwe.fi/uade/download.html"
    regex(/href=.*?uade[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  head do
    url "https://gitlab.com/uade-music-player/uade.git", branch: "master"

    resource "libzakalwe" do
      url "https://gitlab.com/hors/libzakalwe.git", branch: "master"
    end

    resource "bencode-tools" do
      url "https://gitlab.com/heikkiorsila/bencodetools.git", branch: "master"
    end
  end


  depends_on "pkgconf" => :build
  depends_on "libao"

  def install
    lib.mkdir # for libzakalwe

    resource("libzakalwe").stage do
      # Workaround for Xcode 14.3
      if DevelopmentTools.clang_build_version >= 1403
        inreplace "Makefile", "CFLAGS = -W -Wall", "CFLAGS = -Wno-implicit-function-declaration -W -Wall"
      end

      inreplace "Makefile", "-Wl,-soname,$@", "-Wl"
      system "./configure", *std_configure_args
      system "make", "install", "PREFIX=#{prefix}", "CC=#{ENV.cc}"
    end

    resource("bencode-tools").stage do
      system "./configure", "--prefix=#{prefix}", "--without-python"
      system "make"
      system "make", "install"
    end

    system "./configure", "--prefix=#{prefix}",
                          "--libzakalwe-prefix=#{prefix}",
                          "--without-write-audio"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/uade123 --get-info #{test_fixtures("test.mp3")} 2>&1", 1).chomp
    assert_equal "Unknown format: #{test_fixtures("test.mp3")}", output

    assert_match version.to_s, shell_output("#{bin}/uade123 --version")
  end
end
