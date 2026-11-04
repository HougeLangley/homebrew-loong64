class Orcania < Formula
  desc "Potluck with different functions for different purposes in C"
  homepage "https://babelouest.github.io/orcania/"
  url "https://github.com/babelouest/orcania/archive/refs/tags/v2.3.3.tar.gz"
  sha256 "e26947f7622acf3660b71fb8018ee791c97376530ab6c4a00e4aa2775e052626"
  license "LGPL-2.1-only"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1f6d2fb901794610d25e538c249b4b19febedb436b298922f3f860030d8ebbc6"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build

  deny_network_access!

  def install
    args = %W[
      -DDINSTALL_HEADER=ON
      -DBUILD_ORCANIA_DOCUMENTATION=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <orcania.h>
      #include <stdio.h>
      #include <stdlib.h>
      #include <string.h>

      int main() {
          char *src = "Orcania test string";
          char *dup_str;

          // Test o_strdup
          dup_str = o_strdup(src);
          if (dup_str == NULL) {
              printf("o_strdup failed");
              return 1;
          }

          if (strcmp(src, dup_str) != 0) {
              printf("o_strdup did not produce an identical copy");
              free(dup_str);
              return 1;
          }

          free(dup_str);
          printf("Test passed successfully");
          return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lorcania", "-o", "test"
    system "./test"
  end
end
