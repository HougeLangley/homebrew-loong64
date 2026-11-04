class LibjsonRpcCpp < Formula
  desc "C++ framework for json-rpc"
  homepage "https://github.com/cinemast/libjson-rpc-cpp"
  url "https://github.com/cinemast/libjson-rpc-cpp/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "7a057e50d6203e4ea0a10ba5e4dbf344c48b177e5a3bf82e850eb3a783c11eb5"
  license "MIT"
  revision 7
  head "https://github.com/cinemast/libjson-rpc-cpp.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "35fcddb9d3b375999e9e37964161d1803623f780e29dae6015af6d4957d73939"
  end

  depends_on "cmake" => :build
  depends_on "argtable"
  depends_on "hiredis"
  depends_on "jsoncpp"
  depends_on "libmicrohttpd"

  uses_from_macos "curl"

  def install
    # Fix to Policy CMP0042 may not be set to OLD behavior
    # because this version of CMake no longer supports it.
    # Issue ref: https://github.com/cinemast/libjson-rpc-cpp/issues/334
    inreplace "CMakeLists.txt", "cmake_policy(SET CMP0042 OLD)", ""
    args = %W[
      -DCOMPILE_EXAMPLES=OFF
      -DCOMPILE_TESTS=OFF
      -DCMAKE_INSTALL_RPATH=#{rpath}
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"jsonrpcstub", "-h"
  end
end
