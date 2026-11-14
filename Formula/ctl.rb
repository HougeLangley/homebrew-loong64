class Ctl < Formula
  desc "Programming language for digital color management"
  homepage "https://github.com/aces-aswf/CTL"
  url "https://github.com/aces-aswf/CTL/archive/refs/tags/ctl-1.5.5.tar.gz"
  sha256 "b6a36ac31e0a79224216e4fc41b56982939cec7a1afd4e80165cec3f1c37d265"
  license "AMPAS"
  revision 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5a3161c3b3d3ca249344333f6cbdeb10594e3c0fac51732d0b7f118205cce6ce"
  end

  head "https://github.com/aces-aswf/CTL.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "imath"
  depends_on "libtiff"
  depends_on "openexr"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-DCTL_BUILD_TESTS=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "transforms an image", shell_output("#{bin}/ctlrender -help", 1)
  end
end
