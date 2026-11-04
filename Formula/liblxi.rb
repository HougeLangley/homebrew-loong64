class Liblxi < Formula
  desc "Simple C API for communicating with LXI compatible instruments"
  homepage "https://lxi-tools.github.io"
  url "https://github.com/lxi-tools/liblxi/archive/refs/tags/v1.22.tar.gz"
  sha256 "d33ca3990513223880ec238eb2e5aa1cc93aff51c470ef0db9df3e0c332493d5"
  license "BSD-3-Clause"
  revision 1
  head "https://github.com/lxi-tools/liblxi.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "24dbdb3b03450564da5e70ff2aa7c4c15ddfde0ba837c6e186f0829ecbe128ec"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  uses_from_macos "libxml2"

  on_linux do
    depends_on "libtirpc"
  end

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <lxi.h>
      #include <stdio.h>

      int main() {
        return lxi_init();
      }
    C

    args = %W[-I#{include} -L#{lib} -llxi]
    args += %W[-L#{formula_opt_lib("libtirpc")} -ltirpc] if OS.linux?

    system ENV.cc, "test.c", *args, "-o", "test"
    system "./test"
  end
end
