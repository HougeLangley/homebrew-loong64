class Freealut < Formula
  desc "Implementation of OpenAL's ALUT standard"
  homepage "https://github.com/vancegroup/freealut"
  url "https://deb.debian.org/debian/pool/main/f/freealut/freealut_1.1.0.orig.tar.gz"
  sha256 "60d1ea8779471bb851b89b49ce44eecb78e46265be1a6e9320a28b100c8df44f"
  license "LGPL-2.0-only"

  livecheck do
    url "https://deb.debian.org/debian/pool/main/f/freealut/"
    regex(/href=.*?freealut[._-]v?(\d+(?:\.\d+)+)\.orig\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "54d83e6e7b32eb2b9e539dedd057b52ecf232929b1d6d4326e1c16a324338249"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  # Adds the OpenAL frameworks to the library list so linking succeeds
  on_macos do
    patch :DATA
  end

  on_linux do
    depends_on "openal-soft"
  end

  deny_network_access!

  def install
    system "./autogen.sh"
    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"freealut-test.c").write <<~C
      #include <AL/alut.h>
      #include <stdio.h>
      int main() {
        printf("%d.%d\\n", ALUT_API_MAJOR_VERSION, ALUT_API_MINOR_VERSION);
        return 0;
      }
    C
    flags = shell_output("#{bin}/freealut-config --libs --cflags").chop
    system ENV.cc, "freealut-test.c", *flags, "-o", "freealut-test"
    assert_match version.major_minor.to_s, shell_output("./freealut-test")
  end
end

__END__
diff --git a/configure.ac b/configure.ac
index 2b26d6d..4001db1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -83,7 +83,8 @@ AC_DEFINE([ALUT_BUILD_LIBRARY], [1], [Define to 1 if you want to build the ALUT

 # Checks for libraries. (not perfect yet)
 AC_SEARCH_LIBS([pthread_self], [pthread])
-AC_SEARCH_LIBS([alGetError], [openal32 openal])
+# Use Mac OS X frameworks
+LIBS="$LIBS -framework IOKit -framework OpenAL"

 ################################################################################
 # Checks for header files.
