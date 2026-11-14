class Hidapi < Formula
  desc "Library for communicating with USB and Bluetooth HID devices"
  homepage "https://libusb.info/hidapi/"
  url "https://github.com/libusb/hidapi/archive/refs/tags/hidapi-0.15.0.tar.gz"
  sha256 "5d84dec684c27b97b921d2f3b73218cb773cf4ea915caee317ac8fc73cef8136"
  license any_of: ["GPL-3.0-only", "BSD-3-Clause", "HIDAPI"]
  compatibility_version 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cd9134d503b473f6fb874d076eccd145b927dc15a6af72f05305340cf3e75f55"
  end

  head "https://github.com/libusb/hidapi.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  on_linux do
    depends_on "libusb"
    depends_on "systemd" # for libudev
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DHIDAPI_BUILD_HIDTEST=ON",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "hidapi.h"
      int main(void)
      {
        return hid_exit();
      }
    C

    flags = ["-I#{include}/hidapi", "-L#{lib}"]
    flags << if OS.mac?
      "-lhidapi"
    else
      "-lhidapi-hidraw"
    end
    flags += ENV.cflags.to_s.split
    system ENV.cc, "-o", "test", "test.c", *flags
    system "./test"
  end
end
