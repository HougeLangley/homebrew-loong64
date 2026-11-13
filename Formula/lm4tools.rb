class Lm4tools < Formula
  desc "Tools for TI Stellaris Launchpad boards"
  homepage "https://github.com/utzig/lm4tools"
  url "https://github.com/utzig/lm4tools/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "e8064ace3c424b429b7e0b50e58b467d8ed92962b6a6dfa7f6a39942416b1627"
  license all_of: ["GPL-2.0-or-later", "BSD-3-Clause"]


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "746801330f988cbd0e1c5708aae7f91a4b6e205a54b5448c2d5fb069dd706e46"
  end

  depends_on "pkgconf" => :build
  depends_on "libusb"

  def install
    # Historical K&R-style empty parameter lists are not C23 prototypes.
    ENV.append_to_cflags "-std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration"
    # Fix for https://github.com/utzig/lm4tools/issues/32
    libusb = Formula["libusb"]
    inreplace "lmicdiusb/Makefile",
              "LIBUSB_CFLAGS := -I/usr/local/include/libusb-1.0",
              "LIBUSB_CFLAGS := -I#{libusb.opt_include}/libusb-#{libusb.version.major_minor}"
    inreplace "lmicdiusb/Makefile",
              "LIBUSB_LIBDIR := /usr/local/lib",
              "LIBUSB_LIBDIR := #{libusb.opt_lib}"
    inreplace "lmicdiusb/Makefile",
              "lmicdi: lmicdi.o socket.o gdb.o $(LIBUSB_LIBS)",
              "lmicdi: lmicdi.o socket.o gdb.o #{libusb.opt_lib}/#{shared_library("libusb-1.0")}"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    output = pipe_output("#{bin}/lm4flash - 2>&1", "data", 2)
    assert_equal "Unable to find any ICDI devices\n", output
  end
end
