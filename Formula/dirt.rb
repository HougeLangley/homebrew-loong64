class Dirt < Formula
  desc "Experimental sample playback"
  homepage "https://codeberg.org/uzu/dirt"
  url "https://codeberg.org/uzu/dirt/archive/1.1.tar.gz"
  sha256 "5739be152a527352a8fe4c8b7caf0f56add9eb752bef74ab0d815510f6076a1e"
  license "GPL-3.0-or-later"
  revision 1
  head "https://codeberg.org/uzu/dirt.git", branch: "main"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_golden_gate: "1bd47c718cd71cf1feeb41cd924894ffb02664e95d94ff76666715d2b4644433"
    sha256 cellar: :any,                 arm64_tahoe:       "298bd387a65d1a91e835350f47a97b76af44b9466b32b8c2c3a7b67e03736b8c"
    sha256 cellar: :any,                 arm64_sequoia:     "dc07b263a5ea080c3ae14aaaabe185d07c84189e6708cc2206ac74d62e67ec3f"
    sha256 cellar: :any,                 arm64_sonoma:      "dc0671b289e79190e0d962b995c11ba8d0f828fb9a9903c5981e8a7fddca28c0"
    sha256 cellar: :any,                 arm64_ventura:     "7b0e123381c73cf489c38368999dcf0886843f8223562f83db6b6a5fde4dcaf7"
    sha256 cellar: :any,                 arm64_monterey:    "6ac9e97def1a071fda1e4fc145450cdafed11444358537d2824cea8d77e73155"
    sha256 cellar: :any,                 arm64_big_sur:     "ed0c1c48b840abfd9336d6b292e1e08896bddc3663164815fd6fc489b0d3495e"
    sha256 cellar: :any,                 sonoma:            "938298f9f34341b030fec41d4b61002a75ef6a626b7b6a9479584581e52f569c"
    sha256 cellar: :any,                 ventura:           "5ff0f05492f68f79315dd99ce136a09cfb3455b030bf1a12d9164f4dee70b43c"
    sha256 cellar: :any,                 monterey:          "f4c8eaef7bd081e9c346af24400410671665836820077afdcc13e68c676903bd"
    sha256 cellar: :any,                 big_sur:           "bb32869ee985043d05056f89254e369dcc8be8cfaaedaa1427787fc5e04fa62c"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "1ed29d734b4fb03efa5e07a439a7f12b61df0904f8cf4073354ecb2a879eec7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "8ea04b1e39b56f30179c50763b52314bb909285924d3229a68c35905e6b9b0f6"
  end

  depends_on "jack"
  depends_on "liblo"
  depends_on "libsamplerate"
  depends_on "libsndfile"

  def install
    # conf-cc 追加（djb 风格：compile 脚本从 conf-cc 读编译器）
    %w[conf-cc conf-cxx].each do |cf|
      next unless File.exist?(cf)
      _c = File.read(cf).strip
      File.write(cf, _c + " -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration\n") unless _c.include?("gnu17")
    end
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "-DCMAKE_CXX_FLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"].freeze
    # ENV.cc 追加
    _extra = "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration".split
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration " }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    # Work-around for newer clang
    # upstream bug report, https://github.com/tidalcycles/Dirt/issues/66
    ENV.append_to_cflags "-Wno-incompatible-function-pointer-types" if DevelopmentTools.clang_build_version >= 1500

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `...'; ....o:(.bss+0x0): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    inreplace "Makefile", "gcc", ENV.cc

    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "PREFIX=#{prefix}", "install"
  end

  test do
    assert_match "Usage", shell_output("#{bin}/dirt --help; :")
  end
end
