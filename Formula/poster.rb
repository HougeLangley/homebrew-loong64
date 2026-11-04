class Poster < Formula
  desc "Create large posters out of PostScript pages"
  homepage "https://schrfr.github.io/poster/"
  url "https://github.com/schrfr/poster/archive/refs/tags/1.0.0.tar.gz"
  sha256 "1df49dfd4e50ffd66e0b6e279b454a76329a36280e0dc73b08e5b5dcd5cff451"
  license "GPL-2.0-or-later"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "73fb0da41b51ad7947b03bfb5e9255273f2ffe5c842bbe4960d4b3761c94f9e6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "34f60256105b4965b85f65e6dafaba94f046ce0bc39dd94b9ccbdef4721b756a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "e1d75eca414c1495f824f18e6b8007e5352233f9afb9c63d2b588f15f0a44cf8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "9391507786944573699dca31e2089215514fbc3785b8cac70bf3576db33328fc"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "3502b06b6c852fa6ba935acf4a862b72987beff8658b37a11f40cf349acbafde"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "33532f868bdc3667b1be77b533608c5f5837f19fe5683f0ee5d33ec945748e67"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "ebf74df79fee5779f0a6631c938af2db579bfdf27c077fadcca06f21579bfee1"
    sha256 cellar: :any_skip_relocation, sonoma:            "4bb82868022cae59a6c8e6a41374de558382d3cc09998172650de1ce46a5d928"
    sha256 cellar: :any_skip_relocation, ventura:           "fc8ca26f680993d3584c3aaad86a2b9f3ae56d199a0cc614fbb1f93fd27493aa"
    sha256 cellar: :any_skip_relocation, monterey:          "fa63cfd184e101b839afd59ff181bd3e089925ce5a8b93936b579249dd08f955"
    sha256 cellar: :any_skip_relocation, big_sur:           "1dfc4b7649d3ad9c7b22693d9dd966c395a11385c6f5ecea07ab879972f5845f"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "23bc2f446f1525bd074e89f5165a233c8e0080d454d00bd4a4dbbab884334ea1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "623f96d36fc59df594dd8ed5e0073b1d2892e083176346e93821436664351909"
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
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    bin.install "poster"
    man1.install "poster.1"
  end

  test do
    system bin/"poster", test_fixtures("test.ps")
  end
end
