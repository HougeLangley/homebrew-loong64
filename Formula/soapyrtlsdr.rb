class Soapyrtlsdr < Formula
  desc "SoapySDR RTL-SDR Support Module"
  homepage "https://github.com/pothosware/SoapyRTLSDR/wiki"
  url "https://github.com/pothosware/SoapyRTLSDR/archive/refs/tags/soapy-rtlsdr-0.3.4.tar.gz"
  sha256 "1602035b849bca2e9c189712a08d22dc0c7c3a936f9063ac9851bf3229d4460e"
  license "MIT"
  head "https://github.com/pothosware/SoapyRTLSDR.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "55ea4387f5108dfedf38eaf7cf662c41c8d72decc9653407b26748ecfc599995"
  end



  depends_on "cmake" => :build
  depends_on "librtlsdr"
  depends_on "soapysdr"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{formula_opt_bin("soapysdr")}/SoapySDRUtil --check=rtlsdr")
    assert_match "Checking driver 'rtlsdr'... PRESENT", output
  end
end
