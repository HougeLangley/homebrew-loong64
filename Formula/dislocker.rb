class Dislocker < Formula
  desc "FUSE driver to read/write Windows' BitLocker-ed volumes"
  homepage "https://github.com/Aorimn/dislocker"
  url "https://github.com/Aorimn/dislocker/archive/refs/tags/v0.7.4.tar.gz"
  sha256 "c39261727a4993af13f90beec5ce1b56932f8a6d813df26e437ed0a668cf4141"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c7ac47c3fa6c5c78cf7103134d68c2a01cf0d5c628ed3d73dd91a406b0d7bc31"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE
  depends_on "openssl@4"

  deny_network_access!

  def install
    args = %w[
      -DCRYPTO_BACKEND=openssl
      -DWITH_RUBY=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"dislocker", "-h"
  end
end
