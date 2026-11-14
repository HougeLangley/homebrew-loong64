class Mlpack < Formula
  desc "Scalable C++ machine learning library"
  homepage "https://www.mlpack.org"
  url "https://mlpack.org/files/mlpack-4.8.0.tar.gz"
  sha256 "0ab06e5c506c7ed5f072faa4c04477c65624e4a1ff62eee8c0d996ef850ec51c"
  license all_of: ["BSD-3-Clause", "MPL-2.0", "BSL-1.0", "MIT"]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9310aed3cfe0a115200c93c90a3605cdec37d5f351524044c819442674d803cd"
  end

  head "https://github.com/mlpack/mlpack.git", branch: "master"

  livecheck do
    url "https://www.mlpack.org/download.html"
    regex(/href=.*?mlpack[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  depends_on "armadillo"
  depends_on "cereal"
  depends_on "ensmallen"

  resource "stb_image" do
    url "https://raw.githubusercontent.com/nothings/stb/013ac3beddff3dbffafd5177e7972067cd2b5083/stb_image.h"
    version "2.30"
    sha256 "594c2fe35d49488b4382dbfaec8f98366defca819d916ac95becf3e75f4200b3"
  end

  resource "stb_image_write" do
    url "https://raw.githubusercontent.com/nothings/stb/1ee679ca2ef753a528db5ba6801e1067b40481b8/stb_image_write.h"
    version "1.16"
    sha256 "cbd5f0ad7a9cf4468affb36354a1d2338034f2c12473cf1a8e32053cb6914a05"
  end

  def install
    resources.each do |r|
      r.stage do
        (include/"stb").install "#{r.name}.h"
      end
    end

    args = %W[
      -DDEBUG=OFF
      -DPROFILE=OFF
      -DBUILD_TESTS=OFF
      -DUSE_OPENMP=OFF
      -DARMADILLO_INCLUDE_DIR=#{formula_opt_include("armadillo")}
      -DENSMALLEN_INCLUDE_DIR=#{formula_opt_include("ensmallen")}
      -DARMADILLO_LIBRARY=#{formula_opt_lib("armadillo")/shared_library("libarmadillo")}
      -DSTB_IMAGE_INCLUDE_DIR=#{include}/stb
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    doc.install Dir["doc/*"]
    (pkgshare/"tests").install "src/mlpack/tests/data" # Includes test data.
  end

  test do
    system bin/"mlpack_knn",
      "-r", "#{pkgshare}/tests/data/GroupLensSmall.csv",
      "-n", "neighbors.csv",
      "-d", "distances.csv",
      "-k", "5", "-v"

    (testpath/"test.cpp").write <<~CPP
      #include <mlpack/core.hpp>

      using namespace mlpack;

      int main(int argc, char** argv) {
        Log::Debug << "Compiled with debugging symbols." << std::endl;
        Log::Info << "Some test informational output." << std::endl;
        Log::Warn << "A false alarm!" << std::endl;
      }
    CPP
    system ENV.cxx, "-std=c++17", "test.cpp", "-I#{include}", "-L#{formula_opt_lib("armadillo")}",
                    "-larmadillo", "-L#{lib}", "-o", "test"
    system "./test", "--verbose"
  end
end
