class Libdmtx < Formula
  desc "Data Matrix library"
  homepage "https://libdmtx.sourceforge.net/"
  url "https://github.com/dmtx/libdmtx/archive/refs/tags/v0.7.8.tar.gz"
  sha256 "2394bf1d1d693a5a4ca3cfcc1bb28a4d878bdb831ea9ca8f3d5c995d274bdc39"
  license "BSD-2-Clause"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bb143e8b360d5ff11632a45747f5935de497af305529fba7ec16b885785d28c3"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :test

  deny_network_access!

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <string.h>
      #include <dmtx.h>

      int main(void) {
        unsigned char str[] = "Homebrew";
        DmtxEncode *enc = dmtxEncodeCreate();
        if (enc == NULL) return 1;
        if (dmtxEncodeDataMatrix(enc, strlen((const char *)str), str) == DmtxFail) return 1;
        dmtxEncodeDestroy(&enc);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs libdmtx").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    system "./test"
  end
end
