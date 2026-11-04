class Libjaylink < Formula
  desc "Provide interoperability with JLINK hardware"
  homepage "https://gitlab.zapb.de/libjaylink/libjaylink"
  url "https://gitlab.zapb.de/libjaylink/libjaylink/-/archive/0.5.0/libjaylink-0.5.0.tar.bz2"
  sha256 "6c03a9c4d9d781c41ca0f5203e46bebe47ecd5857c6a7d75cbc52accc7be73f8"
  license "GPL-2.0-or-later"
  head "https://gitlab.zapb.de/libjaylink/libjaylink.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e0c606db74615f24cd68665daf33e48487156a6b12033862ec9f65e9973005b6"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  depends_on "libusb"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~CSRC
      #include <stdio.h>
      #include "libjaylink/libjaylink.h"

      int main(void)
      {
        printf("%d.%d.%d",
               jaylink_version_package_get_major(),
               jaylink_version_package_get_minor(),
               jaylink_version_package_get_micro());
        return 0;
      }
    CSRC
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-ljaylink", "-o", "test"
    system "./test"
  end
end
