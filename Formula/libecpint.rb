class Libecpint < Formula
  desc "Library for the efficient evaluation of integrals over effective core potentials"
  homepage "https://github.com/robashaw/libecpint"
  url "https://github.com/robashaw/libecpint/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "e9c60fddb2614f113ab59ec620799d961db73979845e6e637c4a6fb72aee51cc"
  license "MIT"
  revision 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ded65c16519eb8979eaa4c8b6220ac6d11e5d8cf681611bb190483f386574cfc"
  end

  depends_on "cmake" => :build
  depends_on "libcerf"
  depends_on "pugixml"

  uses_from_macos "python" => :build

  patch do
    url "https://github.com/robashaw/libecpint/commit/649e4397a8ad3b90cab247f5a8cb806089583b46.patch?full_index=1"
    sha256 "0ee17dba2c9538ae7756023207370059e7aaf91b6bf63e28c84fc30824cd61b2"
    type :backport
    resolves "https://github.com/robashaw/libecpint/issues/65"
  end

  deny_network_access!

  def install
    args = [
      "-DBUILD_SHARED_LIBS=ON",
      "-DLIBECPINT_USE_CERF=ON",
      "-DLIBECPINT_BUILD_TESTS=OFF",
      "-DPython_EXECUTABLE=#{which("python3")}",
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "tests/lib/api_test1/test1.cpp",
                     "tests/lib/api_test1/api_test1.output",
                     "include/testutil.hpp"
  end

  test do
    cp [pkgshare/"api_test1.output", pkgshare/"testutil.hpp"], testpath
    system ENV.cxx, "-std=c++11", pkgshare/"test1.cpp",
                    "-DHAS_PUGIXML", "-I#{include}/libecpint",
                    "-L#{lib}", "-lecpint", "-o", "test1"
    system "./test1"
  end
end
