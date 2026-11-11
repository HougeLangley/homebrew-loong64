class Pystring < Formula
  desc "Collection of C++ functions for the interface of Python's string class methods"
  homepage "https://github.com/imageworks/pystring"
  url "https://github.com/imageworks/pystring/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "020a603a757ba1e429f4b1ea6feb3afbe0fb34bcafa355032e1f1b8a0019d198"
  license "BSD-3-Clause"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "decbee1f353d850169942510e0c3ff494150790baaa293da771d6cd8d4587064"
  end

  head "https://github.com/imageworks/pystring.git", branch: "master"



  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    include.install "pystring.h"
    pkgshare.install "test.cpp", "unittest.h"
  end

  test do
    system ENV.cxx, "-std=c++11", pkgshare/"test.cpp", "-I#{include}", "-I#{pkgshare}", "-L#{lib}",
                    "-lpystring", "-o", "test"
    system "./test"
  end
end
