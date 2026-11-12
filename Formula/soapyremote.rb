class Soapyremote < Formula
  desc "Use any Soapy SDR remotely"
  homepage "https://github.com/pothosware/SoapyRemote/wiki"
  url "https://github.com/pothosware/SoapyRemote/archive/refs/tags/soapy-remote-0.5.3.tar.gz"
  sha256 "de5bdf209dc93bf7c341077e1e21353037fc387e7c6a9ee41eace3390669dcc1"
  license "BSL-1.0"
  revision 1



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "75d48839cadd0b0b490455398850f00b2f2abe89350850690623ea4ed6e3255d"
  end

  depends_on "cmake" => :build
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
    output = shell_output("#{formula_opt_bin("soapysdr")}/SoapySDRUtil --check=remote")
    assert_match "Checking driver 'remote'... PRESENT", output
  end
end
