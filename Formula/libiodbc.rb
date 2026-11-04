class Libiodbc < Formula
  desc "Database connectivity layer based on ODBC. (alternative to unixodbc)"
  homepage "https://www.iodbc.org/"
  url "https://github.com/openlink/iODBC/releases/download/v3.52.16/libiodbc-3.52.16.tar.gz"
  sha256 "3898b32d07961360f6f2cf36db36036b719a230e476469258a80f32243e845fa"
  license any_of: ["BSD-3-Clause", "LGPL-2.0-only"]

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "22806091cd48ae928f7285e5087f0a4e98ec47105ea0ab43abb11d457c9b8666"
    sha256 cellar: :any,                 arm64_tahoe:       "ab0c5ad41cb17f93a5d9b29ad4d64f6e1be2fb6f1c76bcd7db04b8ded60549e4"
    sha256 cellar: :any,                 arm64_sequoia:     "1a93beeb32954c2c1ce2bb4939c32f1940ec9491ba342ca594fc472bd01852b5"
    sha256 cellar: :any,                 arm64_sonoma:      "9727b705814070058ad5dfc93f33ddb542399e2bd63b09518ce0b779c02aeedc"
    sha256 cellar: :any,                 arm64_ventura:     "c2b3670c3da394419feff4b38ee185e150615479dd3cce7bf02cc2824e461365"
    sha256 cellar: :any,                 arm64_monterey:    "10ca3676025de4d242130feb71200c95a131fa4f28d8201089f0471c2092c0a0"
    sha256 cellar: :any,                 arm64_big_sur:     "5b497dcb9a7aea40f94c0b20cd3c8616d5c3774153286e66bc5ba59e2510131a"
    sha256 cellar: :any,                 sonoma:            "51d457af2187861576522c3a4bf4d9dcd092bd6626b1e9f838a2f717330ed32e"
    sha256 cellar: :any,                 ventura:           "6f63d37fe5d6269eff73a52643932f5cc3c31e10ad9d6fefc90e51244f4ab689"
    sha256 cellar: :any,                 monterey:          "34627b18050d2acbef4503c41e52ac8c3f70443c46fbf18aa9d2947e0f43664f"
    sha256 cellar: :any,                 big_sur:           "90d98eb9831742490c631612df419d83d7c0e2495dab9bc5ddec36ba4e67d8c0"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "2fed59ad000ff8d08665d2ea43a4b4d997fca1fadccc470c58290d72bdc9259d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "6a55f7da0eb9e5afb600e861bb089d7f7a74d393b4c29c9d7d9383c75a717883"
  end

  keg_only "it conflicts with `unixodbc`"

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-big_sur.diff"
    type :unofficial
  end

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
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"iodbc-config", "--version"
  end
end
