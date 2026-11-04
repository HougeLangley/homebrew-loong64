class Libdvdcss < Formula
  desc "Access DVDs as block devices without the decryption"
  homepage "https://www.videolan.org/developers/libdvdcss.html"
  url "https://download.videolan.org/pub/videolan/libdvdcss/1.6.0/libdvdcss-1.6.0.tar.xz"
  sha256 "7ea556c846b7bfc32d47b41cae56d1863a6b6d5f706bb162778d6f298490977c"
  license "GPL-2.0-or-later"
  head "https://code.videolan.org/videolan/libdvdcss.git", branch: "master"

  livecheck do
    url "https://download.videolan.org/pub/libdvdcss/"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "0dbece159119459c389b27eb74fcc80d35a5b73d74e294f7c16f964dbc00b273"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :test

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <dvdcss/version.h>
      #include <stdio.h>

      int main(int argc, char** argv) {
        printf("%s\\n", DVDCSS_VERSION_STRING);
        return 0;
      }
    C

    pkg_config_flags = shell_output("pkgconf --cflags --libs libdvdcss").chomp.split
    system ENV.cc, "test.c", *pkg_config_flags, "-o", "test"
    assert_match version.to_s, shell_output("./test")
  end
end
