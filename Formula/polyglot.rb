class Polyglot < Formula
  desc "Protocol adapter to run UCI engines under XBoard"
  homepage "https://www.chessprogramming.org/PolyGlot"
  url "https://hgm.nubati.net/releases/polyglot-2.0.4.tar.gz"
  sha256 "c11647d1e1cb4ad5aca3d80ef425b16b499aaa453458054c3aa6bec9cac65fc1"
  license "GPL-2.0-or-later"
  head "https://hgm.nubati.net/git/polyglot.git", branch: "learn"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "6d592b3f6e7d014742cae767a1fdac94e82279c1e0480437a6d76550a109eb5d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "6bf5814277c6a0cc6281f0d3e6911d909ef872edc68db77c9a382d17162020af"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7c17a367c2d5da43b534695330ea6467fb27dcd887afeb6dc582601c4a6a5fdc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "bc554a6ab1946c530812eef33e2092102df23edfb12dcb14d98d288b5f15de96"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "0d7bed90c3c1774a9a1765d8305b2fc0c9c38734a478777d35033570777f6a20"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "dbcf961b5015dc2f909d421c6f1967a75110a44fa904718e599aa428341797d6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "74eb07a34cb1629966a192061f5ee507b8ff5db472b1fad9eeddba473b08570c"
    sha256 cellar: :any_skip_relocation, sonoma:            "84974144b7683943964b93e4686af237ef4a36f722b57e6c12dea8a78a65287c"
    sha256 cellar: :any_skip_relocation, ventura:           "719661c4cfbe1a0b809299d9285f4a715100783a6d2e7d8b89a5b3715ff4bb34"
    sha256 cellar: :any_skip_relocation, monterey:          "902514277b538f0d20c73875570832802028e7ba6c3f570ff0c2e4262625d7ea"
    sha256 cellar: :any_skip_relocation, big_sur:           "96fe594c38129a85e97eed368154664e9e318fb16b3f97127a9a4e829ff47f39"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "9ad5fabb4324b9766a57bfb9889d17d2044e0f4ad9cdd8758e8fc968571919d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "8d78f2053c59df94cc0389beaf43906198ebc01dcb86c8cb888fdc6c640a9bc2"
  end

  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", "--prefix=#{prefix}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    assert_match(/^PolyGlot \d\.\d\.[0-9a-z]+ by Fabien Letouzey/, shell_output("#{bin}/polyglot --help"))
  end
end
