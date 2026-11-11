class Yacas < Formula
  desc "General purpose computer algebra system"
  homepage "https://www.yacas.org/"
  url "https://github.com/grzegorzmazur/yacas/archive/refs/tags/v1.9.1.tar.gz"
  sha256 "36333e9627a0ed27def7a3d14628ecaab25df350036e274b37f7af1d1ff7ef5b"
  license "LGPL-2.1-or-later"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9829851fdd1e253437ea6ea37e182a5172081ea883a0c4850f3bb5ff979e5e28"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    cmake_args = [
      "-DENABLE_CYACAS_GUI=OFF",
      "-DENABLE_CYACAS_KERNEL=OFF",
      "-DCMAKE_C_COMPILER=#{ENV.cc}",
      "-DCMAKE_CXX_COMPILER=#{ENV.cxx}",
    ]
    system "cmake", "-S", ".", "-B", "build", *cmake_args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "scripts"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/yacas -v")
  end
end
