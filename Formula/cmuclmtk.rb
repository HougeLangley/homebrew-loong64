class Cmuclmtk < Formula
  desc "Language model tools (from CMU Sphinx)"
  homepage "https://cmusphinx.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/cmusphinx/cmuclmtk/0.7/cmuclmtk-0.7.tar.gz"
  sha256 "d23e47f00224667c059d69ac942f15dc3d4c3dd40e827318a6213699b7fa2915"
  license "BSD-2-Clause"


  deprecate! date: "2026-07-18", because: :unmaintained
  disable! date: "2027-01-18", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0b765857090baa97c9250cd51d8657f0190acd6aab005d1e328be15e99263b57"
  end

  depends_on "pkgconf" => :build

  conflicts_with "julius", because: "both install `binlm2arpa` binaries"

  # Fix errors: call to undeclared function '***';
  # ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  patch :DATA

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    output = pipe_output("#{bin}/text2wfreq", "Hello Hello Homebrew")
    assert_match "Hello 2", output
    assert_match "Homebrew 1", output
  end
end

__END__
diff --git a/src/libs/rr_mkdtemp.c b/src/libs/rr_mkdtemp.c
index 50441ce..ee1f1c5 100755
--- a/src/libs/rr_mkdtemp.c
+++ b/src/libs/rr_mkdtemp.c
@@ -36,6 +36,7 @@

 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/stat.h>

 #include <../win32/compat.h>

diff --git a/src/programs/text2idngram.c b/src/programs/text2idngram.c
index 1ec1cc2..b9ba37b 100644
--- a/src/programs/text2idngram.c
+++ b/src/programs/text2idngram.c
@@ -53,6 +53,8 @@
 #include <string.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>

 #include "../liblmest/toolkit.h"
 #include "../libs/general.h"
diff --git a/src/programs/text2wngram.c b/src/programs/text2wngram.c
index 22ba67d..2790fde 100644
--- a/src/programs/text2wngram.c
+++ b/src/programs/text2wngram.c
@@ -41,11 +41,14 @@
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>

 #include "../liblmest/toolkit.h"
 #include "../libs/pc_general.h"
 #include "../libs/general.h"
 #include "../win32/compat.h"
+#include "../libs/ac_lmfunc_impl.h"

 int cmp_strings(const void *string1,const void *string2) {

diff --git a/src/programs/wngram2idngram.c b/src/programs/wngram2idngram.c
index 3f2ba57..e363282 100644
--- a/src/programs/wngram2idngram.c
+++ b/src/programs/wngram2idngram.c
@@ -47,6 +47,8 @@
 #include <string.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <sys/stat.h>
+#include <unistd.h>

 #include "../liblmest/toolkit.h"
 #include "../libs/general.h"
