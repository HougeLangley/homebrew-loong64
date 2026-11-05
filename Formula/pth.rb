class Pth < Formula
  desc "GNU Portable THreads"
  homepage "https://www.gnu.org/software/pth/"
  url "https://ftpmirror.gnu.org/pth/pth-2.0.7.tar.gz"
  mirror "https://ftp.gnu.org/gnu/pth/pth-2.0.7.tar.gz"
  sha256 "72353660c5a2caafd601b20e12e75d865fd88f6cf1a088b306a3963f0bc77232"
  license "LGPL-2.1-or-later"

  bottle do
    rebuild 2
    sha256 cellar: :any,                 arm64_golden_gate: "5559de3beb57b2b7e04a6625648a716136848b387fd9531aa8a3b115b318af7f"
    sha256 cellar: :any,                 arm64_tahoe:       "5d78afef8be0d57784a9fba9321b7939ac9e57492d9e1ff68192c465d1f001e6"
    sha256 cellar: :any,                 arm64_sequoia:     "ebea43fc620e5a3ca68ab4b1f05222b45ff99430e0572ad43a26ba2dc08178d2"
    sha256 cellar: :any,                 arm64_sonoma:      "2d11f5c8d0c953bd31407c69a481501bac6a990a0ca174304b0e9eae67028a6f"
    sha256 cellar: :any,                 arm64_ventura:     "fab1a0762b2bb6d4a662d7584e7e53a40c0c6e0a47173ee1b352ba5df0307d4c"
    sha256 cellar: :any,                 arm64_monterey:    "43290f4af74260a674cffc3fa75fc0576a89e4040f57473e0601ff3052eca8e9"
    sha256 cellar: :any,                 arm64_big_sur:     "746ea3501c80f444585f9e8c532815ff97cc94e050d1f5672307451abfb1bcfa"
    sha256 cellar: :any,                 sonoma:            "42572a1ad204768fb92064ab80052ae590b6fb75428bfdd3211c3ed15518138c"
    sha256 cellar: :any,                 ventura:           "eb899862aa5c37f46b09b483a9dd2808fd3459f459fa0ebb715a56055e501e1f"
    sha256 cellar: :any,                 monterey:          "13d83d8a576279a5487fe65a8973ac416aacec3f2ca87a8ab3a85bb46b169148"
    sha256 cellar: :any,                 big_sur:           "ce0bf2885f2ff76922d2306e84e328b3bcbe5b3c8365806a66f75d5fce0568fb"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "a8ac563cbeacea2eab01935e62cc4835b1811dfac30f9fb3c0d6a80cfc8b3f41"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "66cd52703b09b137d33237be545677ba50729264ef0ad34d5f4c3891bba86173"
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
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    ENV.deparallelize

    # Fix -flat_namespace usage on macOS.
    inreplace "configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress",
      "${wl}-undefined ${wl}dynamic_lookup"

    args = []
    # Help old config scripts identify arm64 linux
    if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      args += ["--build=aarch64-unknown-linux-gnu", "--host=aarch64-unknown-linux-gnu"]
    end

    # NOTE: The shared library will not be build with --disable-debug, so don't add that flag
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--mandir=#{man}", *args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"pth-config", "--all"
  end
end
