class Bamtools < Formula
  desc "C++ API and command-line toolkit for BAM data"
  homepage "https://github.com/pezmaster31/bamtools"
  url "https://github.com/pezmaster31/bamtools/archive/refs/tags/v2.5.3.tar.gz"
  sha256 "7d4e59bac7c03bde488fe43e533692f78b5325a097328785ec31373ffac08344"
  license "MIT"
  revision 1
  head "https://github.com/pezmaster31/bamtools.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2ed4491e275c259197b5c6eae17802991cca3accd006296a3280f7d71e298227"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "jsoncpp"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # Delete bundled jsoncpp to avoid fallback
    rm_r(buildpath/"src/third_party/jsoncpp")

    # Build shared library
    system "cmake", "-S", ".", "-B", "build_shared",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    *std_cmake_args
    system "cmake", "--build", "build_shared"
    system "cmake", "--install", "build_shared"

    # Build static library
    system "cmake", "-S", ".", "-B", "build_static", *std_cmake_args
    system "cmake", "--build", "build_static"
    lib.install "build_static/src/libbamtools.a"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "api/BamWriter.h"
      using namespace BamTools;
      int main() {
        BamWriter writer;
        writer.Close();
      }
    CPP
    system ENV.cxx, "test.cpp", "-I#{include}/bamtools", "-L#{lib}",
                    "-lbamtools", "-lz", "-o", "test"
    system "./test"
  end
end
