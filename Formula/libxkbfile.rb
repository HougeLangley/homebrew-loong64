class Libxkbfile < Formula
  desc "X.Org: XKB file handling routines"
  homepage "https://www.x.org/"
  url "https://xorg.freedesktop.org/archive/individual/lib/libxkbfile-1.2.0.tar.xz"
  sha256 "7f71884e5faf56fb0e823f3848599cf9b5a9afce51c90982baeb64f635233ebf"
  license "MIT"
  compatibility_version 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "524959ccb7feff2e2271cdf1a8a5d683e19ac183a2a9272cf37d94bd07ca7770"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "libx11"

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <X11/XKBlib.h>
      #include "X11/extensions/XKBfile.h"

      int main(int argc, char* argv[]) {
        XkbFileInfo info;
        return 0;
      }
    C
    system ENV.cc, "test.c"
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
