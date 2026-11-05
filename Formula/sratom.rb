class Sratom < Formula
  desc "Library for serializing LV2 atoms to/from RDF"
  homepage "https://drobilla.net/software/sratom.html"
  url "https://download.drobilla.net/sratom-0.6.22.tar.xz"
  sha256 "0209b7d0f22c96abb416722ed735b0933be47931ecff4aa4b26ded7760b4f252"
  license "ISC"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9af3ba83a668c9bb21095aae0aa307ba17e96a767da7daef02fe6cfc85cb145a"
  end

  livecheck do
    url "https://download.drobilla.net"
    regex(/href=.*?sratom[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "lv2"
  depends_on "serd"
  depends_on "sord"

  def install
    system "meson", "setup", "build", "-Dtests=disabled", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <sratom/sratom.h>

      int main()
      {
        return 0;
      }
    C

    pkg_config_cflags = shell_output("pkg-config --cflags --libs sratom-0").chomp.split
    system ENV.cc, "test.c", *pkg_config_cflags, "-o", "test"
    system "./test"
  end
end
