class Numdiff < Formula
  desc "Putative files comparison tool"
  homepage "https://www.nongnu.org/numdiff"
  url "https://download.savannah.gnu.org/releases/numdiff/numdiff-5.9.0.tar.gz"
  mirror "https://download-mirror.savannah.gnu.org/releases/numdiff/numdiff-5.9.0.tar.gz"
  sha256 "87284a117944723eebbf077f857a0a114d818f8b5b54d289d59e73581194f5ef"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://download.savannah.gnu.org/releases/numdiff/"
    regex(/href=.*?numdiff[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "54cb4ae810757ac9c2aa6891c2e695a1b8d985e235a170bc966037d24dc4cba3"
    sha256 cellar: :any,                 arm64_tahoe:       "54f00b428c20f3de9065177cbc84a59cffb9865351b4062ea429b337197c2c8b"
    sha256 cellar: :any,                 arm64_sequoia:     "5cb5945e56139a742bd1887a3b8a97affe5cb10bac1cafbb5cb40a5b1a70e28d"
    sha256 cellar: :any,                 arm64_sonoma:      "49e592dbd55f5df5add8f7a7814d349cbb150546f672ddca22d12e489ff65fde"
    sha256 cellar: :any,                 arm64_ventura:     "109d8e428ace4ef6d70dc8ded51bec5d0510906e07c9ee4b3e32143f5054c82c"
    sha256 cellar: :any,                 arm64_monterey:    "bdd0116d55164e3704b948d8ff69aa57e3553d7c635897d26e9d381ef67b6dea"
    sha256 cellar: :any,                 arm64_big_sur:     "ee93b5fbe264b96623ef6523a1dec871a5839d56823512da6a7811c06c367d5d"
    sha256 cellar: :any,                 sonoma:            "670605c39b10b5f5eb8fc0227b92d01219f0e08d54ebe26e1e051580e0f838e0"
    sha256 cellar: :any,                 ventura:           "5d48008fe3126fac107bc91308d83fffd39ef5c5e99a4150d52a95febfe573a7"
    sha256 cellar: :any,                 monterey:          "58e6c6f067c9a0ff39143bea741d68c5b50f06ddf7d66f5fbc35f4d691fcfd33"
    sha256 cellar: :any,                 big_sur:           "5acb0364a5f94b40b9f4d79c998910426855da30ea7f7b00241c135ffabdcb8e"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "ebf440325cddaad6e20bce018736dc65e4ea1895de1ce590f21c267b3ab304ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "c9334ab2846721f6a4b643e061dc1ef76f693a8a07f99f05dda3dfdc190165a9"
  end

  depends_on "gmp"

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
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-debug", "--disable-nls", "--enable-gmp",
           "--prefix=#{prefix}", "--libdir=#{lib}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    (testpath/"a").write "1 2\n"
    (testpath/"b").write "1.1 2.5\n"

    expected = <<~EOS
      ----------------
      ##1       #:1   <== 1
      ##1       #:1   ==> 1.1
      @ Absolute error = 1.0000000000e-1, Relative error = 1.0000000000e-1
      ##1       #:2   <== 2
      ##1       #:2   ==> 2.5
      @ Absolute error = 5.0000000000e-1, Relative error = 2.5000000000e-1

      +++  File "a" differs from file "b"
    EOS
    assert_equal expected, shell_output("#{bin}/numdiff a b", 1)
  end
end
