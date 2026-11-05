class SpeechTools < Formula
  desc "C++ speech software library from the University of Edinburgh"
  homepage "http://festvox.org/docs/speech_tools-2.4.0/"
  license "MIT-Festival"
  revision 2
  head "https://github.com/festvox/speech_tools.git", branch: "master"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9608152dc595f6ee8b57c740b75ffd905715149d90eee3a9cd4560992f76fd24"
  end

  stable do
    url "https://deb.debian.org/debian/pool/main/s/speech-tools/speech-tools_2.5.0.orig.tar.gz"
    mirror "http://festvox.org/packed/festival/2.5/speech_tools-2.5.0-release.tar.gz"
    sha256 "e4fd97ed78f14464358d09f36dfe91bc1721b7c0fa6503e04364fb5847805dcc"

    # Fix build on Apple Silicon. Remove in the next release.
    patch do
      url "https://github.com/festvox/speech_tools/commit/06141f69d21bf507a9becb5405265dc362edb0df.patch?full_index=1"
      sha256 "a42493982af11a914d2cf8b97edd287a54b5cabffe6c8fe0e4a9076c211e85ef"
      type :backport
    end

    # Backport fix for building with -fno-common
    patch do
      url "https://github.com/festvox/speech_tools/commit/55bdddcca80906d63090872309c0a7838bf44f44.patch?full_index=1"
      sha256 "0d0b97ea85550a55d09627d388345b16d467f5cbcbb4ab35aa51479950557048"
      type :backport
    end
  end

  livecheck do
    url "http://festvox.org/packed/festival/?C=M&O=D"
    regex(%r{href=["']?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end


  uses_from_macos "ncurses"

  on_macos do
    depends_on "libomp"
  end

  conflicts_with "align", because: "both install `align` binaries"

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
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    ENV.deparallelize
    # Xcode doesn't include OpenMP directly any more, but with these
    # flags we can force the compiler to use the libomp we provided
    # as a dependency.  Normally you can force this on autoconf by
    # setting "ac_cv_prog_cxx_openmp" and "LIBS", but this configure
    # script does OpenMP its own way so we need to actually edit the script:
    inreplace "configure", "-fopenmp", "-Xpreprocessor -fopenmp -lomp" if OS.mac?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    # install all executable files in "main" directory
    bin.install Dir["main/*"].select { |f| File.file?(f) && File.executable?(f) }
  end

  test do
    rate_hz = 16000
    frequency_hz = 100
    duration_secs = 5
    basename = "sine"
    txtfile = "#{basename}.txt"
    wavfile = "#{basename}.wav"
    ptcfile = "#{basename}.ptc"

    File.open(txtfile, "w") do |f|
      scale = (2 ** 15) - 1
      samples = Array.new(duration_secs * rate_hz) do |i|
        (scale * Math.sin(frequency_hz * 2 * Math::PI * i / rate_hz)).to_i
      end
      f.puts samples
    end

    # convert to wav format using ch_wave
    system bin/"ch_wave", txtfile,
      "-itype", "raw",
      "-istype", "ascii",
      "-f", rate_hz.to_s,
      "-o", wavfile,
      "-otype", "riff"

    # pitch tracking to est format using pda
    system bin/"pda", wavfile,
      "-shift", (1 / frequency_hz.to_f).to_s,
      "-o", ptcfile,
      "-otype", "est"

    # extract one frame from the middle using ch_track, capturing stdout
    value = frequency_hz * duration_secs / 2
    pitch = shell_output("#{bin}/ch_track #{ptcfile} -from #{value} -to #{value}")

    # should be 100 (Hz)
    assert_equal frequency_hz, pitch.to_i
  end
end
