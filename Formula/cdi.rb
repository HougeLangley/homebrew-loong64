class Cdi < Formula
  desc "C and Fortran Interface to access Climate and NWP model Data"
  homepage "https://code.mpimet.mpg.de/projects/cdi"
  url "https://code.mpimet.mpg.de/attachments/download/30225/cdi-2.6.3.tar.gz"
  sha256 "7256a0771cb827b9058701d8460e51549736d630b2d4354cdc652221f0f654e2"
  license "BSD-3-Clause"

  livecheck do
    url "https://code.mpimet.mpg.de/projects/cdi/files"
    regex(/href=.*?cdi[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5bb5430253a218cfe78db050208eb01000a7f294e0c71a40d325220e0d550207"
  end

  depends_on "eccodes"
  depends_on "libaec"
  depends_on "netcdf"

  uses_from_macos "python" => :build

  on_linux do
    depends_on "util-linux"
  end

  deny_network_access!

  def install
    args = %W[
      --disable-silent-rules
      --with-eccodes=#{formula_opt_prefix("eccodes")}
      --with-netcdf=#{formula_opt_prefix("netcdf")}
      --with-szlib=#{formula_opt_prefix("libaec")}
    ]

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <cdi.h>
      int main() {
        // Print CDI version
        cdiPrintVersion();

        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcdi", "-o", "test"
    assert_match "CDI library version : #{version}", shell_output("./test")
  end
end
