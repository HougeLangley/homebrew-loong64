class Lame < Formula
  desc "High quality MPEG Audio Layer III (MP3) encoder"
  homepage "https://lame.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/lame/lame/4.0/lame-4.0.tar.gz"
  sha256 "3df5124d5ad3a98312ffd7ba6a9b36230e4f8a3e66d3ce0f425e336c32d216eb"
  license "LGPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/lame[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, arm64_golden_gate: "c7803cbfacfe405583edef9d81056088008b8cb1e8efca6c2ab1983e1af35de6"
    sha256 cellar: :any, arm64_tahoe:       "b0fe0cfb39c74a53b7635833fe3293a62c886b084bc5ccc8ed7cd177803182e4"
    sha256 cellar: :any, arm64_sequoia:     "552d24d56ff0d3255e9a3519a368d0ce45de86b5b2967b338209c1a22cd12969"
    sha256 cellar: :any, arm64_sonoma:      "b0cfa1500aff96430c865fa5e3e8b5494bb9ff70dd4f4fe8f9e7684da626649a"
    sha256 cellar: :any, sonoma:            "62e5e6acdb340cfdae39e4a4ad49e8b2efcd46bfe91897b670a2c0d5a0693c19"
    sha256 cellar: :any, arm64_linux:       "bd3d4df9fd0722b758bea12328bd1345d2ca507842f4074b88fe5d10cae13b73"
    sha256 cellar: :any, x86_64_linux:      "260e9309ef40e8ad7373bfae07f20d5357e036d32b14ea3ce6526fdf15181a37"
  end

  depends_on "pkgconf" => :build
  depends_on "mpg123"

  uses_from_macos "ncurses"

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
    # LAME still calls undeclared legacy ID3 APIs, which do not compile as C23.
    # https://sourceforge.net/p/lame/bugs/517/
    ENV["ac_cv_prog_cc_c23"] = "no"
    ENV.append_to_cflags "-Wno-implicit-function-declaration"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--enable-nasm"
    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"lame", "--genre-list", test_fixtures("test.mp3")
  end
end
