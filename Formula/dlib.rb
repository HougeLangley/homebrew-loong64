class Dlib < Formula
  desc "C++ library for machine learning"
  homepage "https://dlib.net/"
  url "https://github.com/davisking/dlib/archive/refs/tags/v20.0.1.tar.gz"
  sha256 "dab5b4ec4b68bd7dc128a1fb7900723f89d2da107e44cd5def7d38fc57252a9d"
  license "BSL-1.0"
  head "https://github.com/davisking/dlib.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6bc261b561a7a000b923d4eb1b03ad8c2b9b0e912c8fd2f204965d0c772c7675"
  end

  depends_on "cmake" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "openblas"

  deny_network_access!

  def install
    args = %W[
      -DDLIB_USE_BLAS=ON
      -DDLIB_USE_LAPACK=ON
      -Dcblas_lib=#{formula_opt_lib("openblas")/shared_library("libopenblas")}
      -Dlapack_lib=#{formula_opt_lib("openblas")/shared_library("libopenblas")}
      -DDLIB_NO_GUI_SUPPORT=ON
      -DDLIB_LINK_WITH_SQLITE3=OFF
      -DBUILD_SHARED_LIBS=ON
    ]
    args << "-DUSE_SSE2_INSTRUCTIONS=ON" if Hardware::CPU.intel?

    system "cmake", "-S", "dlib", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <dlib/logger.h>
      dlib::logger dlog("example");
      int main() {
        dlog.set_level(dlib::LALL);
        dlog << dlib::LINFO << "The answer is " << 42;
      }
    CPP
    system ENV.cxx, "-pthread", "-std=c++14", "test.cpp", "-o", "test", "-I#{include}",
                    "-L#{lib}", "-ldlib"
    assert_match(/INFO.*example: The answer is 42/, shell_output("./test"))
  end
end
