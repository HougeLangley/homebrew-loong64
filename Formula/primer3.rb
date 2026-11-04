class Primer3 < Formula
  desc "Program for designing PCR primers"
  homepage "https://primer3.org/"
  url "https://github.com/primer3-org/primer3/archive/refs/tags/v2.6.1.tar.gz"
  sha256 "805cef7ef39607cd40f0f5bb8b32e35e20007153a0a55131dd430ce644c8fb9e"
  license all_of: [
    "GPL-2.0-or-later",
    "GPL-3.0-or-later", # Amplicon3
  ]

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "bb8f58342753309dccfde9306639e3bf255d77fa01c31a61a69f8b4202b9b34e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "1b96d43ea44fb89eaf75ea0f5bcc76877ca7d73bac9dc4d2084f971c7e5a3d04"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c7272f6819aa6154307869334e14b9c6bf7f7e2946cb29e6ce27e0e32b591772"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "fe6b4f0f13b4c390a9b0760ec731e50fe176456d404ef253d0b2836fb0924aa9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "8f669fca578e49237e85cfa9ebb37eef493657afdbf7152349d69addb91d4a6d"
    sha256 cellar: :any_skip_relocation, sonoma:            "3b4742c4eb4d8eb8194804c426e4bfcc99816751a67d0a8ed3a9f9a762aa7f8f"
    sha256 cellar: :any_skip_relocation, ventura:           "0451ce226e2aab9d03dbac0cf45b7790650dda666246a0c8f7789c407cdd34d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "ab0022a10895d283cf54cb3c24136a31643345487d75b39d355aa68340ce8904"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "858d715a269e3ecad988c9bbbf7e04df1570e85f601a43bcde16fb8ee94255c2"
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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "-C", "src", "install", "PREFIX=#{prefix}"
    pkgshare.install "src/primer3_config"
    prefix.install "src/LICENSE_GPL3_for_Amplicon3"
  end

  test do
    output = shell_output("#{bin}/long_seq_tm_test AAAAGGGCCCCCCCCTTTTTTTTTTT 3 20")
    assert_match "tm = 52.452902", output.lines.last
  end
end
