class Convertlit < Formula
  desc "Convert Microsoft Reader format eBooks into open format"
  homepage "http://www.convertlit.com/"
  url "http://www.convertlit.com/clit18src.zip"
  version "1.8"
  sha256 "d70a85f5b945104340d56f48ec17bcf544e3bb3c35b1b3d58d230be699e557ba"
  license "GPL-2.0-or-later"


  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "842c1eadb817de6be72f86a24f49ea694c20599b57980f5d713fdef0e57e20b2"
  end

  depends_on "libtommath"

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
    # Workaround for Xcode 14.3
    %w[
      lib/Makefile
      clit18/Makefile
    ].each do |file|
      inreplace file do |s|
        if DevelopmentTools.clang_build_version >= 1403
          s.gsub! " -Wall ", " -Wall -Wno-implicit-function-declaration "
        end
      end
    end

    inreplace "clit18/Makefile" do |s|
      s.gsub! "-I ../libtommath-0.30", "-I#{Formula['libtommath'].opt_include}"
      s.gsub! "../libtommath-0.30/libtommath.a", "#{Formula['libtommath'].opt_lib}/libtommath.a"
    end

    # Do not pass CFLAGS on make's command line: that overrides the original
    # -Ides -Isha -Inewlzx and clit include paths. The blocks above append
    # compatibility flags to both Makefiles while preserving those paths.
    system "make", "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "-C", "lib"
    system "make", "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "-C", "clit18"
    bin.install "clit18/clit"
  end

  test do
    (testpath/"test.lit").write("fake .lit file content")
    (testpath/"exploded").mkpath
    output = shell_output("#{bin}/clit test.lit #{testpath}/exploded 2>&1", 255)
    assert_match "LIT FORMAT ERROR: File is too small", output

    assert_match version.to_s, shell_output(bin/"clit", 255)
  end
end
