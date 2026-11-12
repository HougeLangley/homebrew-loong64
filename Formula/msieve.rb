class Msieve < Formula
  desc "C library for factoring large integers"
  homepage "https://sourceforge.net/projects/msieve/"
  url "https://downloads.sourceforge.net/project/msieve/msieve/Msieve%20v1.53/msieve153_src.tar.gz"
  sha256 "c5fcbaaff266a43aa8bca55239d5b087d3e3f138d1a95d75b776c04ce4d93bb4"
  license :public_domain

  livecheck do
    url :stable
    regex(%r{url=.*?/Msieve%20v?(\d+(?:\.\d+)+)/}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "eaab9780b9b6595897fb4f1663ffead04ba2bc1cc1f1b8df9ff7df773b2acd86"
  end

  depends_on "gmp"

  on_linux do
    depends_on "zlib-ng-compat"
  end

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    ENV.append "MACHINE_FLAGS", "-include sys/time.h"
    # Command-line CFLAGS would discard the upstream include paths and defines.
    system "make", "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "all"
    bin.install "msieve"
  end

  test do
    assert_match "20\np1: 2\np1: 2\np1: 5", shell_output("#{bin}/msieve -q 20")
  end
end
