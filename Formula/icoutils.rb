class Icoutils < Formula
  desc "Create and extract MS Windows icons and cursors"
  homepage "https://www.nongnu.org/icoutils/"
  url "https://download.savannah.gnu.org/releases/icoutils/icoutils-0.32.3.tar.bz2"
  sha256 "17abe02d043a253b68b47e3af69c9fc755b895db68fdc8811786125df564c6e0"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://download.savannah.gnu.org/releases/icoutils/"
    regex(/href=.*?icoutils[._-](\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "93cf10e38bd52d721bea5b6b13f1281e1b6a1cd481bd2132dac68faded9de977"
    sha256 cellar: :any, arm64_tahoe:       "5f28e12b6168d398c1b6a45fdd31fbe562734bf4e0bb9b92473326fe3652db3c"
    sha256 cellar: :any, arm64_sequoia:     "1f134eb8d5bfda13e1afd2742d87488abb2bd651f0ec059b6bbea76add8a647f"
    sha256 cellar: :any, arm64_sonoma:      "273cfd4c47669dcb185b256f41952316faeb9c7f263c86e602b81e5b1d4c9302"
    sha256 cellar: :any, arm64_ventura:     "6d0b6015b32488d5eadeed7af574b0b07c8071dfaae487a41f5306585eb8510b"
    sha256 cellar: :any, arm64_monterey:    "cca2c49761f3c0c2c4d8261af392cb156b43d49e99d16af0962584717c1e2ad3"
    sha256 cellar: :any, arm64_big_sur:     "561bdf394863bd566ebfd0f9f5c5cb084d9eeeeb21c4013dc67f49ca2f382d68"
    sha256 cellar: :any, sonoma:            "09886292b02d85b40a34e8dfe38379b89455ed50cb0002313f88e022906e4927"
    sha256 cellar: :any, ventura:           "bc125498f4fb92c602479703be80ef4e1870dd4f74159e1ed0d2fd801179ba75"
    sha256 cellar: :any, monterey:          "23f46510e0108a2342a83ba36aa2b11346d18a3f5ae29aa238cb249f3e4fa3e8"
    sha256 cellar: :any, big_sur:           "2f71fa8b1131f534d2d7d674642091a80f61108a376240bd6e19c92d436aecfe"
    sha256               arm64_linux:       "628929761f445827749c377cd6309471d0f4f5e70f3f70b6004d052f3dd8d1d0"
    sha256               x86_64_linux:      "4bcbbfe1270c90d060baf5fe79eea7cd07daaae074c110b57e8505eac348cdb8"
  end

  depends_on "libpng"

  on_monterey :or_newer do
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

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
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    # Workaround to avoid C23
    ENV["ac_cv_prog_cc_c23"] = "no"

    inreplace "common/Makefile.am", "libcommon_a_LIBADD", "libcommon_la_LIBADD"

    # Workaround for Xcode 14 ld.
    system "autoreconf", "--force", "--install", "--verbose" if OS.mac? && MacOS.version >= :monterey

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-rpath", *std_configure_args
    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"icotool", "-l", test_fixtures("test.ico")
  end
end
