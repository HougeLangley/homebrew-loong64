class Libbdplus < Formula
  desc "Implements the BD+ System Specifications"
  homepage "https://www.videolan.org/developers/libbdplus.html"
  url "https://get.videolan.org/libbdplus/0.2.0/libbdplus-0.2.0.tar.bz2"
  mirror "https://download.videolan.org/pub/videolan/libbdplus/0.2.0/libbdplus-0.2.0.tar.bz2"
  sha256 "b93eea3eaef33d6e9155d2c34b068c505493aa5a4936e63274f4342ab0f40a58"
  license "LGPL-2.1-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?libbdplus[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "cb3747288e13781a0852c1f131fb80f942c4b63de0c637f51315b3006947510d"
    sha256 cellar: :any,                 arm64_tahoe:       "7b8a3164167b5bc2e357f954ae319df5c9d6d7f0fb7b63f4ef71b65cbec9e3a4"
    sha256 cellar: :any,                 arm64_sequoia:     "9cc87d2f97a8450b3757c16b409e1c13a562e2d0e52492ab9d9cb032c908d600"
    sha256 cellar: :any,                 arm64_sonoma:      "ea38d1a6e93c8fcf4d08039d40e2fdc5fc681a66f1e3377c8e9f56a4992136d2"
    sha256 cellar: :any,                 arm64_ventura:     "f47c8d29158db9c810a1f037d3335ba5cb5b8c8c3769c5435d516f07cef44c73"
    sha256 cellar: :any,                 arm64_monterey:    "c5e53b35cf902a1b1bed758850dc351c5fa005f78147a39085e284b02ddded9f"
    sha256 cellar: :any,                 arm64_big_sur:     "f4b3ecf7789e87ae8ebc97cf9a3c00321c79a3cca58d7a6679ea686da6c415e3"
    sha256 cellar: :any,                 sonoma:            "71cae25b96b7723171f93ab33b2508cff5f8b081165d124dae5a6639b78a62aa"
    sha256 cellar: :any,                 ventura:           "b4b549364f9d64a044ef9e90f7896f1214fef2c8303dfe3bd376af7b95387233"
    sha256 cellar: :any,                 monterey:          "6e72efd19ac6ebf39f3c22240a1e706cd101540a2c2b55c1c83cf4048642339f"
    sha256 cellar: :any,                 big_sur:           "d0e37545cdc9aa4e23e56dfead1e17ed894431e06bcdc06dec76a4ffb32b6deb"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "1f77338b5c92c9187e9ceccd4c0d073227b7e86edac29204f72da202a89259de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "a6adab3c63417c05c7b4e68bebd99dd6e0d133d7d60e1dcfe29552150cb484e0"
  end

  head do
    url "https://code.videolan.org/videolan/libbdplus.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "libgcrypt"
  depends_on "libgpg-error"

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
    system "./bootstrap" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

 test do
  (testpath/"test.c").write <<~C
   #include <libbdplus/bdplus.h>
   int main() {
    int major = -1;
    int minor = -1;
    int micro = -1;
    bdplus_get_version(&major, &minor, &micro);
    return 0;
   }
  C
  system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lbdplus", "-o", "test"
  system "./test"
 end
end
