class Sipp < Formula
  desc "Traffic generator for the SIP protocol"
  homepage "https://sipp.sourceforge.net/"
  url "https://github.com/SIPp/sipp.git",
      tag:      "v3.8.0",
      revision: "c44a9fe5a5896665b2c6a19bfd6190e10a9144e2"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6adf99d86ea8b9bf41d3dbe3d9b8a20f721547c1e2ddd10faf72cd5149a30dac"
  end



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"
  depends_on "pugixml"

  uses_from_macos "libpcap"
  uses_from_macos "ncurses"

  deny_network_access!

  def install
    args = %w[
      -DUSE_PCAP=1
      -DUSE_SSL=1
      -DUSE_SYSTEM_PUGIXML=ON
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "SIPp v#{version}", shell_output("#{bin}/sipp -v", 99)
  end
end
