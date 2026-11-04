class Primesieve < Formula
  desc "Fast C/C++ prime number generator"
  homepage "https://github.com/kimwalisch/primesieve"
  url "https://github.com/kimwalisch/primesieve/archive/refs/tags/v12.16.tar.gz"
  sha256 "753530ec2b4cbf3b62808b0661ab00e0382d47bded8a57c4fe41a6a4409f7c94"
  license "BSD-2-Clause"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6e99d187a4b6035e76b70e200387adc70e08d82177cff7afe6b6c593b3395e75"
  end

  depends_on "cmake" => :build

  deny_network_access!
  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"primesieve", "100", "--count", "--print"
  end
end
