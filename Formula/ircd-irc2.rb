class IrcdIrc2 < Formula
  desc "Original IRC server daemon"
  homepage "https://web.archive.org/web/20240814044559/http://www.irc.org/"
  url "https://web.archive.org/web/20240805183402/http://www.irc.org/ftp/irc/server/irc2.11.2p3.tgz"
  version "2.11.2p3"
  sha256 "be94051845f9be7da0e558699c4af7963af7e647745d339351985a697eca2c81"
  # The `:cannot_represent` is for a Digital Equipment Corporation license.
  # TODO: See if SPDX will consider this a match for HPND License.
  license all_of: [
    "GPL-1.0-or-later",
    "GPL-2.0-or-later", # ircd/fileio.*, ircd/patricia.c
    "ISC", # ircd/res_comp.c
    "BSD-4-Clause-UC", # ircd/{res_comp.c,res_init.c,res_mkquery.c,resolv_def.h}
    :cannot_represent, # ircd/{res_comp.c,res_init.c,res_mkquery.c,resolv_def.h}
  ]


  def default_ircd_conf
    <<~EOS
      # M-Line
      M:irc.localhost::Darwin ircd default configuration::000A

      # A-Line
      A:This is Darwin's default ircd configurations:Please edit your /usr/local/etc/ircd.conf file:Contact <root@localhost> for questions::ExampleNet

      # Y-Lines
      Y:1:90::100:512000:5.5:100.100
      Y:2:90::300:512000:5.5:250.250

      # I-Line
      I:*:::0:1
      I:127.0.0.1/32:::0:1

      # P-Line
      P::::6667:
    EOS
  end

  # Last release on 2010-08-13 and site is down
  deprecate! date: "2025-04-06", because: :unmaintained
  disable! date: "2026-04-06", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "1ccc0217d6920dcddb50d1c87fc70c8400e90995d223893ea4849ac344cecc7f"
  end

  uses_from_macos "libxcrypt"

  on_linux do
    on_arm do
      # Added automake as a build dependency to update config files for ARM support.
      depends_on "automake" => :build
    end
  end

  conflicts_with "ircd-hybrid", because: "both install `ircd` binaries"

  # Replace usage of nameser_def.h which has incompatible IBM license.
  # Ref: https://gitlab.com/fedora/legal/fedora-license-data/-/issues/53
  patch :DATA

  def install
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "-DCMAKE_CXX_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"].freeze
    # ENV.cc 追加
    _extra = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types".split
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types" }
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
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Remove header with incompatible IBM license and add linker flags to use system library instead
    rm("ircd/nameser_def.h")
    ENV.append "LIBS", "-lresolv"

    if OS.linux? && Hardware::CPU.arm?
      # Workaround for ancient config files not recognizing aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp Formula["automake"].share/"automake-#{Formula["automake"].version.major_minor}"/fn, "support/#{fn}"
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}",
                          "--localstatedir=#{var}",
                          "--sysconfdir=#{etc}",
                          "--mandir=#{man}",
                          "CFLAGS=-DRLIMIT_FDMAX=0"

    build_dir = `./support/config.guess`.chomp

    # Disable netsplit detection. In a netsplit, joins to new channels do not
    # give chanop status.
    inreplace "#{build_dir}/config.h", /#define DEFAULT_SPLIT_USERS\s+65000/,
      "#define DEFAULT_SPLIT_USERS 0"
    inreplace "#{build_dir}/config.h", /#define DEFAULT_SPLIT_SERVERS\s+80/,
      "#define DEFAULT_SPLIT_SERVERS 0"

    # The directory is something like `i686-apple-darwin13.0.2'
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install", "-C", build_dir

    (buildpath/"ircd.conf").write default_ircd_conf
    etc.install "ircd.conf"
  end

  service do
    run [opt_sbin/"ircd", "-t"]
    keep_alive false
    working_dir HOMEBREW_PREFIX
    error_log_path var/"ircd.log"
  end

  test do
    system sbin/"ircd", "-version"
  end
end

__END__
diff --git a/ircd/res_comp.c b/ircd/res_comp.c
index b58d06c..a0ff2b9 100644
--- a/ircd/res_comp.c
+++ b/ircd/res_comp.c
@@ -64,6 +64,7 @@ static const volatile char rcsid[] = "$Id: res_comp.c,v 1.10 2004/10/01 20:22:14
 #include "s_externs.h"
 #undef RES_COMP_C

+#if 0
 static int	ns_name_ntop (const u_char *, char *, size_t);
 static int	ns_name_pton (const char *, u_char *, size_t);
 static int	ns_name_unpack (const u_char *, const u_char *,
@@ -75,6 +76,7 @@ static int	ns_name_uncompress (const u_char *, const u_char *,
 static int	ns_name_compress (const char *, u_char *, size_t,
 				      const u_char **, const u_char **);
 static int	ns_name_skip (const u_char **, const u_char *);
+#endif

 /*
  * Expand compressed domain name 'comp_dn' to full domain name.
@@ -306,6 +308,7 @@ static int		dn_find (const u_char *, const u_char *,

 /* Public. */

+#if 0
 /*
  * ns_name_ntop(src, dst, dstsiz)
  *	Convert an encoded domain name to printable ascii as per RFC1035.
@@ -749,6 +752,7 @@ static int	ns_name_skip(const u_char **ptrptr, const u_char *eom)
 	*ptrptr = cp;
 	return (0);
 }
+#endif

 /* Private. */

diff --git a/ircd/s_defines.h b/ircd/s_defines.h
index aaaf0d4..acd1378 100644
--- a/ircd/s_defines.h
+++ b/ircd/s_defines.h
@@ -37,4 +37,5 @@
 #include "service_def.h"
 #include "sys_def.h"
 #include "resolv_def.h"
-#include "nameser_def.h"
+#define BIND_8_COMPAT
+#include <arpa/nameser.h>
