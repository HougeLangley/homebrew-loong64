class Ode < Formula
  desc "Simulating articulated rigid body dynamics"
  homepage "https://www.ode.org/"
  url "https://bitbucket.org/odedevs/ode/downloads/ode-0.16.6.tar.gz"
  sha256 "c91a28c6ff2650284784a79c726a380d6afec87ecf7a35c32a6be0c5b74513e8"
  license any_of: ["LGPL-2.1-or-later", "BSD-3-Clause"]
  head "https://bitbucket.org/odedevs/ode.git", branch: "master"

  livecheck do
    url :head
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "162efc6ad0d7c93698b6422c5cda9b08a16f4806bbd4b82e699356f50bfc0ae6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "libccd"

  # Fix -flat_namespace being used on Big Sur and later.
  # We patch `libtool.m4` and not `configure` because we call `./bootstrap`.
  patch :DATA

  def install
    inreplace "bootstrap", "libtoolize", "glibtoolize"
    system "./bootstrap"

    system "./configure", "--prefix=#{prefix}",
                          "--enable-libccd",
                          "--enable-shared",
                          "--disable-static",
                          "--disable-demos",
                          "--enable-double-precision"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <ode/ode.h>
      int main() {
        dInitODE();
        dCloseODE();
        return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-I#{include}/ode", "-L#{lib}", "-lode",
                   "-L#{formula_opt_lib("libccd")}", "-lccd", "-lm", "-lpthread",
                   "-o", "test"
    system "./test"
  end
end

__END__
diff --git a/m4/libtool.m4 b/m4/libtool.m4
index 10ab284..bfc1d56 100644
--- a/m4/libtool.m4
+++ b/m4/libtool.m4
@@ -1067,16 +1067,11 @@ _LT_EOF
       _lt_dar_allow_undefined='$wl-undefined ${wl}suppress' ;;
     darwin1.*)
       _lt_dar_allow_undefined='$wl-flat_namespace $wl-undefined ${wl}suppress' ;;
-    darwin*) # darwin 5.x on
-      # if running on 10.5 or later, the deployment target defaults
-      # to the OS version, if on x86, and 10.4, the deployment
-      # target defaults to 10.4. Don't you love it?
-      case ${MACOSX_DEPLOYMENT_TARGET-10.0},$host in
-	10.0,*86*-darwin8*|10.0,*-darwin[[91]]*)
-	  _lt_dar_allow_undefined='$wl-undefined ${wl}dynamic_lookup' ;;
-	10.[[012]][[,.]]*)
+    darwin*)
+      case ${MACOSX_DEPLOYMENT_TARGET},$host in
+	10.[[012]],*|,*powerpc*)
 	  _lt_dar_allow_undefined='$wl-flat_namespace $wl-undefined ${wl}suppress' ;;
-	10.*)
+	*)
 	  _lt_dar_allow_undefined='$wl-undefined ${wl}dynamic_lookup' ;;
       esac
     ;;
