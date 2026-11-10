class Convertlit < Formula
  desc "Convert Microsoft Reader format eBooks into open format"
  homepage "http://www.convertlit.com/"
  url "http://www.convertlit.com/clit18src.zip"
  version "1.8"
  sha256 "d70a85f5b945104340d56f48ec17bcf544e3bb3c35b1b3d58d230be699e557ba"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f509f1e2a4dd042ae325e96072a15bb7fa4f77923ff9dc51773494cc72094e25"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "0cfe39c84460ec28081f4e2fa92771253085837c8986d9d3121c573eb1a6a072"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "af81e33973b458225160387d713ab4646496719b4c0a3ae064dccf92c7e3efbd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "f0df27834c193ce4b6f3d17a63c072818bd667f2d98b653f166c024d3bdafbdb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "723db1f95f54e5f9003305056b3e67c5d2e6eb424fb18cc4e366a2dbe53756d4"
    sha256 cellar: :any_skip_relocation, sonoma:            "061b39d2c0b09a6bd68c6f1219b396e558cd4cbe8dcbaf64968079bb2c2a9253"
    sha256 cellar: :any_skip_relocation, ventura:           "47c22a8704d183095db27702edb6dbe248f4cbf88b3aeb788ea2686656ddf05a"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "28b8504282e33b2b346b2bc88313fcaac3d9525327d576341adb40b7da58b0af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "c9e0dbeb09435b5d6c8a8f0e728d345185e14bb1bd4a799c05a1cefde6938046"
  end

  deprecate! date: "2026-01-05", because: "is not available via HTTPS"
  disable! date: "2027-01-05", because: "is not available via HTTPS"

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
      s.gsub! "-I ../libtommath-0.30", "#{HOMEBREW_PREFIX}/include"
      s.gsub! "../libtommath-0.30/libtommath.a", "#{HOMEBREW_PREFIX}/lib/libtommath.a"
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
