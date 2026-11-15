class Libgeotiff < Formula
  desc "Library and tools for dealing with GeoTIFF"
  homepage "https://github.com/OSGeo/libgeotiff"
  license "MIT"

  compatibility_version 1

  stable do
    url "https://github.com/OSGeo/libgeotiff/releases/download/1.7.4/libgeotiff-1.7.4.tar.gz"
    sha256 "c598d04fdf2ba25c4352844dafa81dde3f7fd968daa7ad131228cd91e9d3dc47"

    # Fix -flat_namespace being used on Big Sur and later.
    patch do
      file "Patches/libtool/configure-big_sur.diff"
    end
  end

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1b2b9e32ec573693e0946671709af718d40f4c391f567d73722e6f586998c194"
  end

  head do
    url "https://github.com/OSGeo/libgeotiff.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "jpeg-turbo"
  depends_on "libtiff"
  depends_on "proj"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./autogen.sh" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args, "--with-jpeg"
    system "make" # Separate steps or install fails
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "geotiffio.h"
      #include "xtiffio.h"
      #include <stdlib.h>
      #include <string.h>

      int main(int argc, char* argv[])
      {
        TIFF *tif = XTIFFOpen(argv[1], "w");
        GTIF *gtif = GTIFNew(tif);
        TIFFSetField(tif, TIFFTAG_IMAGEWIDTH, (uint32) 10);
        GTIFKeySet(gtif, GeogInvFlatteningGeoKey, TYPE_DOUBLE, 1, (double)123.456);

        int i;
        char buffer[20L];

        memset(buffer,0,(size_t)20L);
        for (i=0;i<20L;i++){
          TIFFWriteScanline(tif, buffer, i, 0);
        }

        GTIFWriteKeys(gtif);
        GTIFFree(gtif);
        XTIFFClose(tif);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lgeotiff",
                   "-L#{formula_opt_lib("libtiff")}", "-ltiff", "-o", "test"
    system "./test", "test.tif"
    output = shell_output("#{bin}/listgeo test.tif")
    assert_match(/GeogInvFlatteningGeoKey.*123\.456/, output)
  end
end
