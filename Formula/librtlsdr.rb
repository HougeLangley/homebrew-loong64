class Librtlsdr < Formula
  desc "Use Realtek DVB-T dongles as a cheap SDR"
  homepage "https://osmocom.org/projects/rtl-sdr/wiki"
  url "https://github.com/steve-m/librtlsdr/archive/refs/tags/v2.0.3.tar.gz"
  sha256 "851b87a62e548470c287c26669b83abb665d83bccb8d8492d07a697c7b9c4e37"
  license "GPL-2.0-or-later"
  compatibility_version 1
  head "https://git.osmocom.org/rtl-sdr", using: :git, branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7f20742519c1589fa824ddd0a52fd7f6d319877ce224ce56997b053cb5079187"
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "libusb"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "rtl-sdr.h"

      int main()
      {
        rtlsdr_get_device_count();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lrtlsdr", "-o", "test"
    system "./test"
  end
end
