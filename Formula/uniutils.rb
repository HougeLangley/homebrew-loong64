class Uniutils < Formula
  desc "Manipulate and analyze Unicode text"
  homepage "https://billposer.org/Software/unidesc.html"
  url "https://billposer.org/Software/Downloads/uniutils-2.28.tar.gz"
  sha256 "41c14c0223376f2d96c80c2ba1b1494fc74cd8982d561630e688e2245aaf3364"
  license all_of: [
    "GPL-2.0-or-later",
    "GPL-3.0-only",
  ]

  livecheck do
    url :homepage
    regex(/href=.*?uniutils[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "c76e5c96dc6013e88d9817f0cc154a5d78153695b741ba29cf1d0b91c18fe2b1"
    sha256 cellar: :any,                 arm64_tahoe:       "c8c2a6ab2e7fd876281c9b107d275f17ab9620a3241a664cdd11af7f02d08fc2"
    sha256 cellar: :any,                 arm64_sequoia:     "b1e77b1c7bb772f82fa4f847d6d08f8b7b4da149516636d45ec0aaa662937490"
    sha256 cellar: :any,                 arm64_sonoma:      "d2e0b6cb5b9a69c9c3b7741b22d800538287c470d377c7796487146cb7875f33"
    sha256 cellar: :any,                 arm64_ventura:     "a7487de087156bf2db6b8db4966e4d8864a822c21da7c07d9c740a17be5771b9"
    sha256 cellar: :any,                 arm64_monterey:    "3c4ddbab225f52bd4b6b2b46f35a3a01f827f52367b3cf709251c7eeda260ede"
    sha256 cellar: :any,                 sonoma:            "6cb5418da4466190223532647f17da877e3af7d19fe61fce7f56fc1465e47c25"
    sha256 cellar: :any,                 ventura:           "6ec87153855511c01c9ec16b2d917c8e80517b3a5da69f74b34f2e40f540b1dc"
    sha256 cellar: :any,                 monterey:          "432cba754fdf29b6e4e99e43a45f4340047dbe3042038ab8c2de173c7bfdc596"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "2ff9239b9e70ce2c37680c210c047c0b8d7b88b68058550a267b98643c1f358c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "b35edd0447764ae2524bba5bf3eb9178d70a5a3559b4c896e8ac8bfaf65f2466"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_macos do
    depends_on "gettext" # for libintl
  end

  # Allow build with clang. This patch was reported to debian here:
  # https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=740968
  # And emailed to the upstream source at billposer@alum.mit.edu
  patch :DATA

  def install
    # conf-cc 追加（djb 风格：compile 脚本从 conf-cc 读编译器）
    %w[conf-cc conf-cxx].each do |cf|
      next unless File.exist?(cf)
      _c = File.read(cf).strip
      File.write(cf, _c + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types\n") unless _c.include?("gnu17")
    end
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types " }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # fix `./install-sh: Permission denied` issue
    system "autoreconf", "--force", "--install", "--verbose"

    # workaround for Xcode 14.3
    if DevelopmentTools.clang_build_version >= 1403
      ENV.append "CFLAGS", "-Wno-implicit-function-declaration -Wno-implicit-int"
    end
    # autoconf 2.73 selects C23, which rejects the implicit declarations in this codebase
    ENV["ac_cv_prog_cc_c23"] = "no"

    # fix `_libintl_bindtextdomain` and `_libintl_textdomain` symbols not found
    gettext = Formula["gettext"]
    ENV.append "CFLAGS", "-I#{gettext.include}"
    ENV.append "LDFLAGS", "-L#{gettext.lib}"
    ENV.append "LDFLAGS", "-lintl" if OS.mac?

    system "./configure", "--disable-silent-rules", "--mandir=#{man}", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    s = pipe_output("#{bin}/uniname", "ü")
    assert_match "LATIN SMALL LETTER U WITH DIAERESIS", s
  end
end

__END__
Description: Fix clang FTBFS [-Wreturn-type]
Author: Nicolas Sévelin-Radiguet <nicosr@free.fr>
Last-Update: 2014-03-06
--- a/unifuzz.c
+++ b/unifuzz.c
@@ -97,7 +97,7 @@
 }

 /* Emit the middle character from each range */
-EmitAllRanges(short AboveBMPP) {
+void EmitAllRanges(short AboveBMPP) {
   int i;
   UTF32 scp;
   extern int Ranges_Defined;
