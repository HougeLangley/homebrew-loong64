class Flvmeta < Formula
  desc "Manipulate Adobe flash video files (FLV)"
  homepage "https://flvmeta.com/"
  url "https://github.com/noirotm/flvmeta/archive/refs/tags/v1.3.1.tar.gz"
  sha256 "e1a7449d5ff1d601f85534d5acb41bcb5f6adf785473401ca755fcdfb1874c00"
  license "GPL-2.0-or-later"
  head "https://github.com/noirotm/flvmeta.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f3e5de1b55a56f71360a0233e26093b3be7198e81c76e59cdf237ca7130678a3"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"flvmeta", "-V"
  end
end
