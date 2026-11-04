class Cbmbasic < Formula
  desc "Commodore BASIC V2 as a scripting language"
  homepage "https://github.com/mist64/cbmbasic"
  url "https://downloads.sourceforge.net/project/cbmbasic/cbmbasic/1.0/cbmbasic-1.0.tgz"
  sha256 "2735dedf3f9ad93fa947ad0fb7f54acd8e84ea61794d786776029c66faf64b04"
  license "BSD-2-Clause"
  head "https://github.com/mist64/cbmbasic.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6a9d5d335ac73d9308a4e5ab6f1ab9a6f623810e7ca9ff287bd965baf141cce0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7a998e7b4ececefdb1441daedfc1d7e21499bf353d7d2b38f43ce9506eb7e876"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "12b112458c348c5267a9dd565cd6eb627e77e5f7601aa8262192ef0547f5c824"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "6009d0ea2c22b727d92fa669b8d2d2207caf0cd9651d74a771c2dd35f24596aa"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "8382a3a84c232895e8581de79435c6c7629079ec8dbdec6b8d193f73715e4ca8"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "4e090b459f2e44ad8f04e3e70a25b909fe16771f4b2fa325cc06ea233b019803"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "b693c2b8fbfe49736bdc0ae4bce13d96295da75a6683e593c021c9335f6c57fd"
    sha256 cellar: :any_skip_relocation, sonoma:            "b6c3dab8aa52d31126d5945c15334343b4d83adc3c9ba4b0502709d6c4cc7bc1"
    sha256 cellar: :any_skip_relocation, ventura:           "032eb3fb2490ed7ae7d4017bffd81e1052fbae0929427a6efc55cb2e612dae18"
    sha256 cellar: :any_skip_relocation, monterey:          "1328d1be681fd3f2be33cbab9b19e59a71e1ed0a5191c89bf7595ebcf0ef3236"
    sha256 cellar: :any_skip_relocation, big_sur:           "29f1eb35e6acf1bf907d2c89c0f5938507718b290cdeef92dfcee473b00f8fe5"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "0d449cf17cf6a0c1b07c3f46721f68ec826913f703e7e98daeb6b5e42cfe2867"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "0e08527ac4b01d5d2c747776b5d8be5ae6e402862a87bafe7331c3c3b49d6170"
  end

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `RAM'; cbmbasic.o:(.bss+0x10): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "CFLAGS=#{ENV.cflags}", "LDFLAGS=#{ENV.ldflags}"
    bin.install "cbmbasic"
  end

  test do
    assert_match(/READY.\r\n 1/, pipe_output(bin/"cbmbasic", "PRINT 1\n", 0))
  end
end
