class Lv < Formula
  desc "Powerful multi-lingual file viewer/grep"
  # The upstream homepage was "https://web.archive.org/web/20160310122517/www.ff.iij4u.or.jp/~nrt/lv/"
  homepage "https://salsa.debian.org/debian/lv"
  url "https://salsa.debian.org/debian/lv/-/archive/debian/4.51-10.1/lv-debian-4.51-10.1.tar.gz"
  version "4.51-10.1"
  sha256 "64c1efb7d66301625d3a46dd4b3abed45942b2686de335860bf24a37b01ea858"
  license "GPL-2.0-or-later"
  head "https://salsa.debian.org/debian/lv.git", branch: "master"

  bottle do
    sha256                               arm64_golden_gate: "3dfee5fae1612af246fff036926f594fa9940d4d3b66d676b31d724d7059a1f2"
    sha256                               arm64_tahoe:       "ecb4b2ddef16ba003c1bed5ba898b4d7938b86d06b8d47a1a2f10bd1b9e1b34e"
    sha256                               arm64_sequoia:     "efaec6f504463810396e09314511c35269bf24a9e032190aff1be242605d3245"
    sha256                               arm64_sonoma:      "3ca1bf0482f72301256a514a9b707981422d9c2307e2561eef693bab87c02697"
    sha256                               sonoma:            "e0400df58db2d0cffa3be9f627cdd7439be8388f4cf15d7d557747fe2b5c6e1a"
    sha256                               arm64_linux:       "f540993311d9f5564f0b2d6b9781927fe862e475ff901748d37eb989f55fb04a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "51062f445c5a3c2bbdb8573e5a5a58affe8a0629fe10773ec2f1b204dda4873c"
  end

  uses_from_macos "ncurses"

  on_linux do
    depends_on "gzip"
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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    File.read("debian/patches/series").each_line do |line|
      line.chomp!
      system "patch", "-p1", "-i", "debian/patches/"+line
    end

    cd "build" do
      system "../src/configure", "--prefix=#{prefix}"
      system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
      bin.install "lv"
      bin.install_symlink "lv" => "lgrep"
    end

    man1.install "lv.1"
    (lib/"lv").install "lv.hlp"
  end

  test do
    system bin/"lv", "-V"
  end
end
