class Libdv < Formula
  desc "Codec for DV video encoding format"
  homepage "https://libdv.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/libdv/libdv/1.0.0/libdv-1.0.0.tar.gz"
  sha256 "a305734033a9c25541a59e8dd1c254409953269ea7c710c39e540bd8853389ba"
  license "LGPL-2.1-or-later"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "866661452a78484c4c31c29274a71aaff2f435f9e8a65edf7694c3f46770aa21"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "popt"

  # On macOS, _SC_PRIORITY_SCHEDULING is defined but sched_setscheduler is unavailable
  # https://sourceforge.net/p/libdv/patches/43/
  patch :p0 do
    url "https://sourceforge.net/p/libdv/patches/_discuss/thread/7c774d02/1f37/attachment/libdv-1.0.0-darwin.patch"
    sha256 "6c9632b4ff6a6580b00f294b5db5b27e058fc04b87f4cf2134e056da13f0a305"
    type :unofficial
  end

  # remove SDL1 dependency by force
  patch :DATA

  def install
    system "autoreconf", "--force", "--install", "--verbose"

    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", "--disable-asm",
                          "--disable-gtktest",
                          "--disable-gtk",
                          "--disable-sdltest",
                          *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"dubdv", "--version"
    system bin/"dvconnect", "--version"
  end
end

__END__
diff --git a/configure.ac b/configure.ac
index 2b95735..1ba9370 100644
--- a/configure.ac
+++ b/configure.ac
@@ -173,13 +173,6 @@ dnl used in Makefile.am
 AC_SUBST(GTK_CFLAGS)
 AC_SUBST(GTK_LIBS)
 
-if $use_sdl; then
-	AM_PATH_SDL(1.1.6,
-	[
-		AC_DEFINE(HAVE_SDL) 
- 	])
-fi
-
 if [ $use_gtk && $use_xv ]; then
 	AC_CHECK_LIB(Xv, XvQueryAdaptors,
 		[AC_DEFINE(HAVE_LIBXV)
