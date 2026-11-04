class Wfa2Lib < Formula
  desc "Wavefront alignment algorithm library v2"
  homepage "https://github.com/smarco/WFA2-lib"
  url "https://github.com/smarco/WFA2-lib/archive/refs/tags/v2.3.6.tar.gz"
  sha256 "fd74c4bfdd5764ae8668cdeee7a80bfa35583b1980e261daa9dbf425bf12bb0b"
  license "MIT"
  head "https://github.com/smarco/WFA2-lib.git", branch: "main"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c9f97e636e87a7c89f194ab5465150a6e92137b3582d54299803604225e35d62"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  on_macos do
    depends_on "libomp"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", "-DOPENMP=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "examples"
  end

  test do
    system ENV.cc, pkgshare/"examples/wfa_basic.c", "-o", "test", "-I#{include}/wfa2lib", "-L#{lib}", "-lwfa2", "-lm"
    assert_match "WFA-Alignment returns score -24", shell_output("./test 2>&1")
  end
end
