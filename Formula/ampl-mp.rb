class AmplMp < Formula
  desc "Open-source library for mathematical programming"
  homepage "https://ampl.com/"
  url "https://github.com/ampl/mp/archive/refs/tags/v4.1.0.tar.gz"
  sha256 "c75274fe2ef8b61f67826267e3c2cb339021c62d724659ab89a5b63c3959067d"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1db3ea5a743174ebad96b7b553e18125bb5c1455dad520e46be7181fc6009a5a"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %W[
      -DAMPL_LIBRARY_DIR=#{libexec}/bin
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_TESTS=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath};#{rpath(source: libexec/"bin")}
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include "mp/ampls-c-api.h"

      int main() {
          AMPLS_MP_Solver* solver = (AMPLS_MP_Solver*)malloc(sizeof(AMPLS_MP_Solver));
          free(solver);
          return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}/mp", "-L#{lib}", "-lmp", "-o", "test"
    system "./test"
  end
end
