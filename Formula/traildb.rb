class Traildb < Formula
  desc "Blazingly-fast database for log-structured data"
  homepage "https://traildb.io/"
  url "https://github.com/traildb/traildb/archive/refs/tags/0.6.tar.gz"
  sha256 "f73515fe56c547f861296cf8eecc98b8e8bf00d175ad9fb7f4b981ad7cf8b67c"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end




  depends_on "pkgconf" => :build
  depends_on "judy"
  depends_on "libarchive"

  uses_from_macos "python" => :build

  # Update waf script for Python 3
  # Use resource instead of patch since applying corrupts waf
  resource "waf" do
    on_macos do
      url "https://raw.githubusercontent.com/traildb/traildb/053ed8e5d0301c792f3ee703cd9936c49ecf41a1/waf"
      sha256 "2e0cf83a63843da127610420cef1d3126f1187d8e572b6b3a28052fc2250d4bf"
    end
    on_linux do
      # Update `waf` further for Python 3.12+ support. We don't use this on macOS as newer versions
      # fail to find `libarchive` on non-/usr/local prefix due to wscript PKG_CONFIG_PATH override
      url "https://waf.io/waf-2.1.4"
      sha256 "7803d63e698ada49a74ab6979a0fd708a5f9a3456206cba3a3e07387fdcf946d"
    end
  end

  def install
    ENV["PREFIX"] = prefix
    resource("waf").stage { buildpath.install Dir["*"].first => "waf" }
    system "python3", "./waf", "configure", "install"
  end

  test do
    # Check that the library has been installed correctly
    (testpath/"test.c").write <<~C
      #include <traildb.h>
      #include <assert.h>
      int main() {
        const char *path = "test.tdb";
        const char *fields[] = {};
        tdb_cons* c1 = tdb_cons_init();
        assert(tdb_cons_open(c1, path, fields, 0) == 0);
        assert(tdb_cons_finalize(c1) == 0);
        tdb* t1 = tdb_init();
        assert(tdb_open(t1, path) == 0);
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-ltraildb", "-o", "test"
    system "./test"

    # Check that the provided tdb binary works correctly
    (testpath/"in.csv").write("1234 1234\n")
    system bin/"tdb", "make", "-c", "-i", "in.csv", "--tdb-format", "pkg"
  end
end
