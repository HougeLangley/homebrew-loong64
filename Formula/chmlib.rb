class Chmlib < Formula
  desc "Library for dealing with Microsoft ITSS/CHM files"
  # Upstream site went down in 2026, so use the Wayback Machine (`id_` serves the original bytes)
  homepage "https://web.archive.org/web/20260415074851/https://www.jedrea.com/chmlib/"
  url "https://web.archive.org/web/20260414144043id_/https://www.jedrea.com/chmlib/chmlib-0.40.tar.gz"
  sha256 "512148ed1ca86dea051ebcf62e6debbb00edfdd9720cde28f6ed98071d3a9617"
  license "LGPL-2.1-or-later"


  # Upstream homepage is gone
  deprecate! date: "2026-09-14", because: :repo_removed
  disable! date: "2026-12-14", because: :repo_removed

  # Fix -flat_namespace being used on Big Sur and later.
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0c8bcdefa8307684fd435d588854d507368b09bc434138d9563d65bb94dd364c"
  end

  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  # Add aarch64 and loongarch64 to the 64-bit integer platform list.
  # Fix implicit function declarations, for C99 compatibility: https://github.com/jedwing/CHMLib/pull/17
  patch :DATA

  def install
    # conf-cc 追加（djb 风格：compile 脚本从 conf-cc 读编译器）
    %w[conf-cc conf-cxx].each do |cf|
      next unless File.exist?(cf)
      _c = File.read(cf).strip
      File.write(cf, _c + " -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration\n") unless _c.include?("gnu17")
    end
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "-DCMAKE_CXX_FLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"].freeze
    # ENV.cc 追加
    _extra = "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration".split
    Dir["Makefile", "GNUmakefile", "makefile", "src/Makefile"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/-std=(c|gnu)(89|99|11|17|2x)/, "")
      File.write(mkf, _m)
    end
    # Makefile 里面追加（硬编码 CFLAGS 时 ENV 追加不生效）
    Dir["Makefile", "GNUmakefile", "makefile", "**/Makefile", "**/GNUmakefile", "**/makefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration " }
      File.write(mkf, _m)
    end
    # 老包自带的 config.sub/config.guess 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    args = %W[
      --disable-io64
      --enable-examples
      --prefix=#{prefix}
    ]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args
    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <chm_lib.h>
      int main() {
        struct chmFile* chm = chm_open("file-that-doesnt-exist.chm");
        return chm != 0; // Fail if non-null.
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lchm", "-o", "test"
    system "./test"
  end
end

__END__
diff --git a/src/chm_lib.c b/src/chm_lib.c
index 6c6736c..06908c0 100644
--- a/src/chm_lib.c
+++ b/src/chm_lib.c
@@ -164,7 +164,7 @@ typedef unsigned long long      UInt64;

 /* x86-64 */
 /* Note that these may be appropriate for other 64-bit machines. */
-#elif __x86_64__ || __ia64__
+#elif __x86_64__ || __ia64__ || __aarch64__ || __loongarch64
 typedef unsigned char           UChar;
 typedef short                   Int16;
 typedef unsigned short          UInt16;
diff --git a/src/chm_http.c b/src/chm_http.c
index 237e85a..1df2adb 100644
--- a/src/chm_http.c
+++ b/src/chm_http.c
@@ -43,6 +43,8 @@
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <netinet/in.h>
+#include <arpa/inet.h>
+#include <unistd.h>

 /* threading includes */
 #include <pthread.h>
diff --git a/src/chm_lib.c b/src/chm_lib.c
index ffd213c..9eb9d1b 100644
--- a/src/chm_lib.c
+++ b/src/chm_lib.c
@@ -48,6 +48,8 @@
  *                                                                         *
  ***************************************************************************/

+#define _LARGEFILE64_SOURCE /* for pread64 */
+
 #include "chm_lib.h"

 #ifdef CHM_MT
