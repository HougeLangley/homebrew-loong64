class Splint < Formula
  desc "Secure Programming Lint"
  homepage "https://splint.org/"
  license "GPL-2.0-or-later"

  stable do
    url "https://splint.org/downloads/splint-3.1.2.src.tgz"
    mirror "https://mirrorservice.org/sites/distfiles.macports.org/splint/splint-3.1.2.src.tgz"
    sha256 "c78db643df663313e3fa9d565118391825dd937617819c6efc7966cdf444fb0a"

    # fix compiling error of osd.c
    patch :DATA
  end

  livecheck do
    url :head
    regex(/^(?:splint[._-])?v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end

  bottle do
    rebuild 1
    sha256                               arm64_golden_gate: "e5b6b7f3b93c3246f9d585f84231051c75d37026e6b5d0a80ab42e1b4f744301"
    sha256                               arm64_tahoe:       "3d26b806b15af6dde29829bdca6d9c0cc44ac7ef96d5522dee1cbd3f24a9924e"
    sha256                               arm64_sequoia:     "71b5c97c68f8d10d646955b1111d8556dc2f0ab90136dafd78f5beb673533fb3"
    sha256                               arm64_sonoma:      "b7570a4d7dbb53a9da6cc06e69bb7fd2a850829fe93ea39ffc14f494c4b1c58b"
    sha256                               arm64_ventura:     "6aae55c464e14dde1a9aa9f49da8e30d8184fcf12fbe06a9e913e1fc313455fa"
    sha256                               arm64_monterey:    "f47715d1e6f0f201c2486f0d788fd138e89b86cd0c11477b3e5576fa49cffc83"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "229d18ade0e3dfc1c9ed796732a57bb385de5dfd8c15d3b265c4ef42cfd5f765"
    sha256                               sonoma:            "a0123a9c0adb426819b56a79a095066f4aa2fa13c6bf501c212eb58e3cbe08b8"
    sha256                               ventura:           "2b3eaa69bb97239d281a12e678c4a5314413d3cc6543742fd67a6ec1e7d987a6"
    sha256                               monterey:          "fa3307d22e30d030cc844b92c91891cfe0581226726a7ad54e1cec82dec07189"
    sha256 cellar: :any_skip_relocation, big_sur:           "bbe9dd0df4449df4259f44c16dc1505e6cdde38c0e7b7cc275d17ae974c8a3b2"
    sha256                               arm64_linux:       "6003db1cf73e332befaff1d85a5a3c547a094594e014b775cfe55914158dff58"
    sha256                               x86_64_linux:      "fded0340d91cfcbd99ddf5a89b505fd59895e980d86366654196192d6358a97c"
  end

  head do
    url "https://github.com/splintchecker/splint.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "bison" => :build
    depends_on "flex"
  end

  uses_from_macos "flex"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

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
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    ENV.deparallelize # build is not parallel-safe

    if build.head?
      ENV.append "CFLAGS", "-std=gnu99"
      system "./bootstrap"
    else
      args = ["--mandir=#{man}"]
      args << "LEXLIB=#{formula_opt_lib("flex")}/libfl.so" if OS.linux?
      # Help old config scripts identify arm64 linux
      args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
      args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    path = testpath/"test.c"
    path.write <<~C
      #include <stdio.h>
      int main()
      {
          char c;
          printf("%c", c);
          return 0;
      }
    C

    output = shell_output("#{bin}/splint #{path} 2>&1", 1)
    assert_match(/5:18:\s+Variable c used before definition/, output)
  end
end


__END__
diff --git a/src/osd.c b/src/osd.c
index ebe214a..4ba81d5 100644
--- a/src/osd.c
+++ b/src/osd.c
@@ -516,7 +516,7 @@ osd_getPid ()
 # if defined (WIN32) || defined (OS2) && defined (__IBMC__)
   int pid = _getpid ();
 # else
-  __pid_t pid = getpid ();
+  pid_t pid = getpid ();
 # endif

   return (int) pid;
