class Libwpe < Formula
  desc "General-purpose library for WPE WebKit"
  homepage "https://wpewebkit.org/"
  url "https://github.com/WebPlatformForEmbedded/libwpe/releases/download/1.16.3/libwpe-1.16.3.tar.xz"
  sha256 "c880fa8d607b2aa6eadde7d6d6302b1396ebc38368fe2332fa20e193c7ee1420"
  license "BSD-2-Clause"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8551a10e70ad0c03df13c66fda679eb65b79326888b7dc8f9aefe87d0170e69b"
  end

  head "https://github.com/WebPlatformForEmbedded/libwpe.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "libxkbcommon"
  depends_on :linux
  depends_on "mesa"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"wpe-test.c").write <<~C
      #include "wpe/wpe.h"
      #include <stdio.h>
      int main() {
        printf("%u.%u.%u", wpe_get_major_version(), wpe_get_minor_version(), wpe_get_micro_version());
      }
    C
    ENV.append_to_cflags "-I#{include}/wpe-1.0"
    ENV.append "LDFLAGS", "-L#{lib}"
    ENV.append "LDLIBS", "-lwpe-1.0"
    system "make", "wpe-test"
    assert_equal version.to_s, shell_output("./wpe-test")
  end
end
