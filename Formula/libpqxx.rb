class Libpqxx < Formula
  desc "C++ connector for PostgreSQL"
  homepage "https://pqxx.org/development/libpqxx/"
  url "https://github.com/jtv/libpqxx/archive/refs/tags/8.0.2.tar.gz"
  sha256 "028c5fba4982e759fe182af1103ccd08b02bb4e1f9f12a551e01d21cac0c4440"
  license "BSD-3-Clause"
  compatibility_version 2



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0f5d27a988c290cd3e4f91e509d135890864a780d0077968bf268460edca51bb"
  end

  depends_on "cmake" => :build
  depends_on "libpq"

  uses_from_macos "python" => :build

  fails_with :gcc do
    version "12"
    cause "Requires C++20 std::format, https://gcc.gnu.org/gcc-13/changes.html#libstdcxx"
  end

  deny_network_access!

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DSKIP_BUILD_TEST=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <pqxx/pqxx>
      int main(int argc, char** argv) {
        pqxx::connection con;
        return 0;
      }
    CPP
    system ENV.cxx, "-std=c++20", "test.cpp", "-L#{lib}", "-lpqxx",
           "-I#{include}", "-o", "test"
    # Running ./test will fail because there is no running postgresql server
    # system "./test"
  end
end
