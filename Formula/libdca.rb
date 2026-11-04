class Libdca < Formula
  desc "Library for decoding DTS Coherent Acoustics streams"
  homepage "https://www.videolan.org/developers/libdca.html"
  url "https://download.videolan.org/pub/videolan/libdca/0.0.7/libdca-0.0.7.tar.bz2"
  sha256 "3a0b13815f582c661d2388ffcabc2f1ea82f471783c400f765f2ec6c81065f6a"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://download.videolan.org/pub/videolan/libdca/"
    regex(%r{href=.*?v?(\d+(?:\.\d+)+)[/"'>]}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c196f62913cba511f9e4b20dd6725a513489b0ba457f617f2926400fe77aff8f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  resource "homebrew-testdata", :test do
    url "https://github.com/foo86/dcadec-samples/raw/fa7dcf8c98c6d/xll_71_24_96_768.dtshd"
    sha256 "d2911b34183f7379359cf914ee93228796894e0b0f0055e6ee5baefa4fd6a923"
  end

  def install
    # Fixes "duplicate symbol ___sputc" error when building with clang
    # https://github.com/Homebrew/homebrew/issues/31456
    ENV.append "CFLAGS", "-std=gnu89"

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    resource("homebrew-testdata").stage do
      system bin/"dcadec", "-o", "null", resource("homebrew-testdata").cached_download
    end
  end
end
