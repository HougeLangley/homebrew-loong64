class ApacheArrowAdbc < Formula
  desc "Cross-language, Arrow-native database access"
  homepage "https://arrow.apache.org/adbc"
  url "https://www.apache.org/dyn/closer.lua?path=arrow/apache-arrow-adbc-25/apache-arrow-adbc-25.tar.gz"
  sha256 "de2910f951eeb3c57d882e621a32d133580cc6b0ad01ac25056f4ac709b8b2c0"
  license "Apache-2.0"
  compatibility_version 1
  head "https://github.com/apache/arrow-adbc.git", branch: "main"

  livecheck do
    url "https://archive.apache.org/dist/arrow/"
    regex(%r{href=["']?apache-arrow-adbc[._-]v?(\d+(?:\.\d+)*)/}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f0bc26e28e36ca5361a3436be28b56f5b669a44318a0885143d544c692c36458"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  deny_network_access!

  def install
    args = %w[
      -DADBC_BUILD_STATIC=OFF
      -DADBC_BUILD_SHARED=ON
      -DADBC_DRIVER_MANAGER=ON
      -DADBC_DRIVER_POSTGRESQL=OFF
      -DADBC_DRIVER_SQLITE=OFF
    ]
    system "cmake", "-S", "c", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "arrow-adbc/adbc.h"
      int main(void) {
        struct AdbcError error;
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++17", "-I#{include}", "-L#{lib}", "-ladbc_driver_manager", "-o", "test"
    system "./test"
  end
end
