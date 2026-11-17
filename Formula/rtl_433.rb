class Rtl433 < Formula
  desc "Program to decode radio transmissions from devices"
  homepage "https://github.com/merbanan/rtl_433"
  url "https://github.com/merbanan/rtl_433/archive/refs/tags/25.12.tar.gz"
  sha256 "d283ec7a41a02d398e8918b20b65df3bf684cf4478371830662004005dadcdd2"
  license "GPL-2.0-or-later"
  revision 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "28aeb2a8bb6329eb48c26dee75c66eb6d48686d257ea7af02d48b0934b908014"
  end

  head "https://github.com/merbanan/rtl_433.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "librtlsdr"
  depends_on "libusb"
  depends_on "openssl@4"

  resource "homebrew-test_cu8", :test do
    url "https://raw.githubusercontent.com/merbanan/rtl_433_tests/038234077f4d8b9022759430da1154d2c3631344/tests/oregon_scientific/uvr128/g001_433.92M_250k.cu8"
    sha256 "7aa07b72cec9926f463410cda6056eb2411ac9e76006ba4917a0527492c5f65d"
  end

  # Test needs to download resources
  allow_network_access! :test

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    testpath.install resource("homebrew-test_cu8")

    # Check following if test fails on new release
    # https://github.com/merbanan/rtl_433_tests/blame/master/tests/oregon_scientific/uvr128/g001_433.92M_250k.json
    expected = {
      "time"       => "@0.156680s",
      "model"      => "Oregon-UVR128",
      "id"         => 150,
      "uvi"        => 0.000,
      "battery_ok" => 1,
    }

    output = shell_output("#{bin}/rtl_433 -c 0 -F json -r #{testpath}/g001_433.92M_250k.cu8")
    assert_equal expected, JSON.parse(output.chomp)
  end
end
