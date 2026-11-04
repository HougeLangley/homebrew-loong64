class Cpio < Formula
  desc "Copies files into or out of a cpio or tar archive"
  homepage "https://www.gnu.org/software/cpio/"
  url "https://ftpmirror.gnu.org/cpio/cpio-2.15.tar.bz2"
  mirror "https://ftp.gnu.org/gnu/cpio/cpio-2.15.tar.bz2"
  sha256 "937610b97c329a1ec9268553fb780037bcfff0dcffe9725ebc4fd9c1aa9075db"
  license "GPL-3.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b945a688c55cdca954fe6ca77d1bf85d3979d672ba21476af63daaa7589fe87e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "a1aa072a11ce1402aaf38319e6fc087b9bf4fa029f2b76cc748b0d122f0cdce0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "fced3fb939f4c350d3ba4b81b2b071d9510728ea28135429cdc150d40f7a1477"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "3fd07e72e7f35a4b9e3c7114906c3d791c59adc2cf91b5cf9fed06962e08be3d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "75fbea8507a8460214cc41c28fdf6926422d246f970e67a701e5e946703a8705"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "bdad2638579eb0a993bad15fd244fafe6ce6383c58b4d09df5c98d8902cbbc2c"
    sha256 cellar: :any_skip_relocation, sonoma:            "e260092a61bec8fc1530706591dca1fc31b01588d87edc3d1f0114f0960039e6"
    sha256 cellar: :any_skip_relocation, ventura:           "7ae883284d803554f4f3076ab924591d1238a2e73847d852decf8c4e78757494"
    sha256 cellar: :any_skip_relocation, monterey:          "a1c05981aecaf5198d77c3d1b306e4923494c1d22d0f6bbfd1b1f344b35732b9"
    sha256                               arm64_linux:       "dd5fa00e86db6b05086c040acbecdb7b0867c3eded3b4a49cf5033afbcba5bb2"
    sha256                               x86_64_linux:      "33defec9f9f862c3db63da0e7ca4020a8fe6552fb51f3adfdf6d01837ce7fdda"
  end

  keg_only :shadowed_by_macos, "macOS provides cpio"

  deny_network_access!

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
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"

    return if OS.mac?

    # Delete rmt, which causes conflict with `gnu-tar`
    (libexec/"rmt").unlink
    (man8/"rmt.8").unlink
  end

  test do
    (testpath/"test.cc").write <<~CPP
      #include <iostream>
      #include <string>
    CPP
    system "ls #{testpath} | #{bin}/cpio -ov > #{testpath}/directory.cpio"
    assert_path_exists "#{testpath}/directory.cpio"
  end
end
