class Ssldump < Formula
  desc "SSLv3/TLS network protocol analyzer"
  homepage "https://adulau.github.io/ssldump/"
  url "https://github.com/adulau/ssldump/archive/refs/tags/v1.9.tar.gz"
  sha256 "c81ce58d79b6e6edb8d89822a85471ef51cfa7d63ad812df6f470b5d14ff6e48"
  license "BSD-4-Clause"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "92757b4f958b8896ffbb1fbde8ecf5f4c5b853d74a1c5678e4a9c90f3148d230"
  end

  depends_on "cmake" => :build
  depends_on "json-c"
  depends_on "libnet"
  depends_on "libpcap"
  depends_on "openssl@3" # TODO: OpenSSL 4 issue - https://github.com/adulau/ssldump/issues/168

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"ssldump", "-v"
  end
end
