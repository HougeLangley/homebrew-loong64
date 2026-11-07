class Exempi < Formula
  desc "Library to parse XMP metadata"
  homepage "https://libopenraw.freedesktop.org/exempi/"
  url "https://libopenraw.freedesktop.org/download/exempi-2.6.6.tar.bz2"
  sha256 "7513b7e42c3bd90a58d77d938c60d2e87c68f81646e7cb8b12d71fe334391c6f"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?exempi[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "28ad526f726411624794da00b8ca0099f06004c7509c7f55d885b71dcd57c283"
  end

  uses_from_macos "expat"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", "--disable-unittest", *std_configure_args
    system "make", "install"
  end

  test do
    cp test_fixtures("test.jpg"), testpath

    (testpath/"test.cpp").write <<~CPP
      #include <cassert>
      #include <exempi/xmp.h>
      #include <exempi/xmpconsts.h>

      int main() {
        const char *filename = "test.jpg";
        assert(xmp_init());
        assert(xmp_files_check_file_format(filename) == XMP_FT_JPEG);

        XmpFilePtr f = xmp_files_open_new(filename, XMP_OPEN_FORUPDATE);
        assert(f != NULL);
        XmpPtr xmp = xmp_files_get_new_xmp(f);
        assert(xmp != NULL);
        assert(xmp_files_can_put_xmp(f, xmp));

        assert(xmp_register_namespace(NS_CC, "cc", NULL));
        assert(xmp_set_property(xmp, NS_CC, "license", "Foo", 0));
        assert(xmp_files_put_xmp(f, xmp));

        assert(xmp_free(xmp));
        assert(xmp_files_close(f, XMP_CLOSE_SAFEUPDATE));
        xmp_terminate();
        return 0;
      }
    CPP

    system ENV.cxx, "test.cpp", "-o", "test", "-I#{include}/exempi-2.0", "-L#{lib}", "-lexempi"
    system "./test"
  end
end
