class Pcalc < Formula
  desc "Calculator for those working with multiple bases, sizes, and close to the bits"
  homepage "https://github.com/alt-romes/programmer-calculator"
  url "https://github.com/alt-romes/programmer-calculator/archive/refs/tags/v3.0.tar.gz"
  sha256 "6ede71e1442710e73edb99eb1742452e67ad5095cad328526633722850aa1136"
  license "GPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6e4237d4fb002b1efa0adf6fa4cbdcd7be849ec4d8c0bf74acc6f0536459d2c1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "3ab7fd9f1bd17b8ae50aaf5c5e419e1ba13214e5362f09b235b834555001ab6e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "a2b4d667859884ae73bdc1d92bcb74b9cd916f249e72b7ff11c55850caa0f83d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "1213e5809a02adfdb8f3d9b37c9fc20f3bdc55f33f165c40205bab09fd118bad"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "8726e03985b7241593b16d00eafd49b008e479058d3bf984da595c3e4cc2195a"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "8cb160f96c00151800102a58e493b8e394bfdaea743329ca7af245502185bdf5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "ba2a72db4f367a3ae6dceef1eba8eb5e9ea84586acef55d163d53503a3ffddb1"
    sha256 cellar: :any_skip_relocation, sonoma:            "d42537f4273abcdc5edac493debde8238b833ec7110e6686692ce00128c85661"
    sha256 cellar: :any_skip_relocation, ventura:           "7929c84fa052dc93f47b5dfe37d4332ff916e2c300739b08f721e72bea265a86"
    sha256 cellar: :any_skip_relocation, monterey:          "2259c04f3360d9bb7c26693fe47651972408c21d2b18a7760ecc218d2e2a33ab"
    sha256 cellar: :any_skip_relocation, big_sur:           "bfef357df427a5d36419bee76ac2a65ce36e191c354d9d773f53b3ed6fd7058f"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "8d33ee09634262b3a6328d6c1bea82836652fbae7b797f2d507026491d25fd47"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "3bfe8638f58d9b4a6b71c50f08d37b6bf10e773ff1d43946879269cf00df69d4"
  end

  uses_from_macos "ncurses"

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    bin.install "pcalc"
  end

  test do
    assert_equal "Decimal: 0, Hex: 0x0, Operation:  \nDecimal: 3, Hex: 0x3, Operation:",
      pipe_output("#{bin}/pcalc -n", "0x1+0b1+1\nquit\n", 0).strip
  end
end
