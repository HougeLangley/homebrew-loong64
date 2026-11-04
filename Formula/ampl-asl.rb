class AmplAsl < Formula
  desc "AMPL Solver Library"
  homepage "https://ampl.com/"
  url "https://github.com/ampl/asl/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "57b767161fd95869757daa0761d9b19fa39ad5de4315f95a3c0dff08b0d4c4f2"
  license "BSD-3-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b4a0006992b88681d3d212bf5875c18cb12432bd9cc209516a31ee9417b4d9ec"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
    ]
    args << "-DUSE_LTO=OFF" if OS.linux?
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <stdlib.h>
      #include "asl/asl.h"

      int main() {
          void* asl_instance = malloc(sizeof(void));
          free(asl_instance);
          return 0;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-I#{include}/asl", "-L#{lib}", "-lasl"
    system "./test"
  end
end
