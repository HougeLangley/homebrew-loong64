class Soapyhackrf < Formula
  desc "SoapySDR HackRF module"
  homepage "https://github.com/pothosware/SoapyHackRF/wiki"
  url "https://github.com/pothosware/SoapyHackRF/archive/refs/tags/soapy-hackrf-0.3.5.tar.gz"
  sha256 "0ef13ac8cf1ec0c0728bdfe8a775e38fd06574418948e3a30ea6794de5d5a06c"
  license "MIT"
  revision 1



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9e30890b52f97b719efc35db3eb4bc48e8c71d08519f5dbe1bda66a4ac689d0d"
  end

  depends_on "cmake" => :build
  depends_on "hackrf"
  depends_on "soapysdr"

  deny_network_access!

  def install
    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{formula_opt_bin("soapysdr")}/SoapySDRUtil --check=hackrf")
    assert_match "Checking driver 'hackrf'... PRESENT", output
  end
end
