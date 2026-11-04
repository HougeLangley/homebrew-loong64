class Libharu < Formula
  desc "Library for generating PDF files"
  homepage "https://github.com/libharu/libharu"
  url "https://github.com/libharu/libharu/archive/refs/tags/v2.4.6.tar.gz"
  sha256 "ec8f327520d1d354ce58b5d2af75b64f380cddc522437c169463b39760921348"
  license "Zlib"
  compatibility_version 1
  head "https://github.com/libharu/libharu.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "55d7d3e282c8142efe76e7a8c3aba8749aad8436618ca72e9893c34205e3309a"
  end

  depends_on "cmake" => :build
  depends_on "libpng"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # Build shared library
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DBUILD_SHARED_LIBS=ON"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Build static library
    system "cmake", "-S", ".", "-B", "build-static", *std_cmake_args, "-DBUILD_SHARED_LIBS=OFF"
    system "cmake", "--build", "build-static"
    lib.install "build-static/src/libhpdf.a"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "hpdf.h"

      int main(void)
      {
        int result = 1;
        HPDF_Doc pdf = HPDF_New(NULL, NULL);

        if (pdf) {
          HPDF_AddPage(pdf);

          if (HPDF_SaveToFile(pdf, "test.pdf") == HPDF_OK)
            result = 0;

          HPDF_Free(pdf);
        }

        return result;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lhpdf", "-o", "test"
    system "./test"
  end
end
