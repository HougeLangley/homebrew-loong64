class Librttopo < Formula
  desc "RT Topology Library"
  homepage "https://git.osgeo.org/gitea/rttopo/librttopo"
  url "https://deb.debian.org/debian/pool/main/libr/librttopo/librttopo_1.1.0.orig.tar.gz"
  sha256 "2e2fcabb48193a712a6c76ac9a9be2a53f82e32f91a2bc834d9f1b4fa9cd879f"
  license "GPL-2.0-or-later"
  compatibility_version 1
  head "https://git.osgeo.org/gitea/rttopo/librttopo.git", branch: "master"

  livecheck do
    url :head
    regex(/^(?:librttopo[._-])?v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e7c2652101dde0336d26b6f9dc37c756e6fc47e75c0c99c8e7677635202ffc85"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "geos"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <librttopo.h>

      int main(int argc, char *argv[]) {
        printf("%s", rtgeom_version());
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lrttopo", "-o", "test"
    assert_equal stable.version.to_s, shell_output("./test")
  end
end
