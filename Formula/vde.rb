class Vde < Formula
  desc "Ethernet compliant virtual network"
  homepage "https://github.com/virtualsquare/vde-2"
  url "https://github.com/virtualsquare/vde-2/archive/refs/tags/v2.3.3.tar.gz"
  sha256 "a7d2cc4c3d0c0ffe6aff7eb0029212f2b098313029126dcd12dc542723972379"
  license all_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"]
  head "https://github.com/virtualsquare/vde-2.git", branch: "master"

  bottle do
    sha256 arm64_golden_gate: "972ce0f14fb0fe92932f45b887019b228ac4529f06d0a95eeb88ece1359d76ba"
    sha256 arm64_tahoe:       "7d38316ce1948eb727d590d88e81fb5c74f2ae4f0dcd9b7161266a4af1ff2e3b"
    sha256 arm64_sequoia:     "1e3ffe05a0f354b3909f74d3374fc036156c438147f5ac8dd34a8f747071e9f8"
    sha256 arm64_sonoma:      "3d2231810ad7229ba6a68178d648ab1f13bdfe50b214cb2d299d644d66e03762"
    sha256 arm64_ventura:     "982a56825cbd1bd374001330e3492e83a1d82825ed7228d33705ffad3b927e8e"
    sha256 arm64_monterey:    "0cd674a5b677c8e4deb2735884366f6a384b0867aa7483e7293e361cbaab350e"
    sha256 arm64_big_sur:     "55d8e9f7b7e4f4593c6a3a4c88f4d6f11c76a8839b876fe63cae40d01e6312dc"
    sha256 sonoma:            "9015f4eeed08db31898c74789119cbc543776f6eb13f4428da554f5d240c1697"
    sha256 ventura:           "e203e8f3933c5dcdc45cdaae85f63b31ecd38a86d90eb5f4f0c1fd7825ad2347"
    sha256 monterey:          "88cc1ceea76bdf304ec6750a2c54c979b34869d853fe6942aff1b23ea213f83e"
    sha256 big_sur:           "05e4b0a57c14a91bf9fbf6afc1cda903fe07504da5545ba4de72c7bf09d53893"
    sha256 arm64_linux:       "522952a405fbeafae167b3a044c95156d29ee89adbe317818906e750c0edf557"
    sha256 x86_64_linux:      "d9ab4e00d44ce831749d0d4363ffee5332295292a5ebcf2d5379d64796b549d9"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

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
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    ENV.append "CFLAGS", "-std=gnu17" if DevelopmentTools.clang_build_version >= 1700
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"vde_switch", "-v"
  end
end
