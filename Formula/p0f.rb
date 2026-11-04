class P0f < Formula
  desc "Versatile passive OS fingerprinting, masquerade detection tool"
  homepage "https://lcamtuf.coredump.cx/p0f3/"
  url "https://lcamtuf.coredump.cx/p0f3/releases/p0f-3.09b.tgz"
  sha256 "543b68638e739be5c3e818c3958c3b124ac0ccb8be62ba274b4241dbdec00e7f"
  license "LGPL-2.1-only"

  livecheck do
    url :homepage
    regex(/href=.*?p0f[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t/i)
  end


  uses_from_macos "libpcap"

  # Fix Xcode 12 issues with "-Werror,-Wimplicit-function-declaration"
  patch :DATA

  bottle do
    rebuild 4
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d5cbb96a4d5b5b3031f879118af3727901ca74e9b0e34a76b1a8f71858d51f68"
  end

  def install
    inreplace "config.h", "p0f.fp", "#{etc}/p0f/p0f.fp"
    system "./build.sh"
    sbin.install "p0f"
    (etc/"p0f").install "p0f.fp"
  end

  test do
    system sbin/"p0f", "-r", test_fixtures("test.pcap")
  end
end

__END__
--- p0f-3.09b/build.sh.ORIG	2020-12-23 03:36:51.000000000 +0000
+++ p0f-3.09b/build.sh	2020-12-23 03:41:54.000000000 +0000
@@ -174,7 +174,7 @@
 
 echo "OK"
 
-echo -n "[*] Checking for *modern* GCC... "
+echo -n "[*] Checking if $CC supports -Wl,-z,relro -pie ... "
 
 rm -f "$TMP" "$TMP.c" "$TMP.log" || exit 1
 
@@ -197,7 +197,7 @@
 
 rm -f "$TMP" "$TMP.c" "$TMP.log" || exit 1
 
-echo -e "#include \"types.h\"\nvolatile u8 tmp[6]; int main() { printf(\"%d\x5cn\", *(u32*)(tmp+1)); return 0; }" >"$TMP.c" || exit 1
+echo -e "#include <stdio.h>\n#include \"types.h\"\nvolatile u8 tmp[6]; int main() { printf(\"%d\x5cn\", *(u32*)(tmp+1)); return 0; }" >"$TMP.c" || exit 1
 $CC $USE_CFLAGS $USE_LDFLAGS "$TMP.c" -o "$TMP" &>"$TMP.log"
 
 if [ ! -x "$TMP" ]; then
