class FastqTools < Formula
  desc "Small utilities for working with fastq sequence files"
  homepage "https://github.com/dcjones/fastq-tools"
  url "https://github.com/dcjones/fastq-tools/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "0cd7436e81129090e707f69695682df80623b06448d95df483e572c61ddf538e"
  license "MIT"

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "91c84044c3fc97320f60c80532ed16641edeb8c77c1892d8963261ab4e874c74"
    sha256 cellar: :any,                 arm64_tahoe:       "f57dd1230850ef71d77be3507a7b7067f4d0a22eb574fffc98c1f5fe1a62bbe4"
    sha256 cellar: :any,                 arm64_sequoia:     "676774cb2b0ed5421d985f2e97120b61d9b0e376b21ca90415bf6e25ba98407a"
    sha256 cellar: :any,                 arm64_sonoma:      "f790be169a1f463a9e0dcc3993d4d7d5071da117bb1b370777af61212bb42bdd"
    sha256 cellar: :any,                 arm64_ventura:     "edcf84aaac94da45c90a5a300ad484b6e958cd59878970d8a60dd679e0f89949"
    sha256 cellar: :any,                 arm64_monterey:    "8580b8ff6e5de04a060b60b5251d01fad27a25c8c4e1b1afdc9534e9ae445cdc"
    sha256 cellar: :any,                 arm64_big_sur:     "ac48791014e14979ad786e59178d0b468510d02f5d51a86608b388adad4405f1"
    sha256 cellar: :any,                 sonoma:            "4e0e4080fa409044a22ab8aa950634cc040b66e17cdc7019409a2b559738709a"
    sha256 cellar: :any,                 ventura:           "a69e35ad7cc93c6481de5b86c4482200ce80e417472c77ae1eae5d0bf98c22ab"
    sha256 cellar: :any,                 monterey:          "0ead212cb078edbf77f9e58d4186dd4aac103fadd8291c6bc328312cf6383b4c"
    sha256 cellar: :any,                 big_sur:           "18f3e795ec5c2c182bfc995ce662816cf17ccbd719fef30937f5456d28bbccc5"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "6705cf6567e0d7c7f8fcb8af52cfc0bd8dcf62b6ad61339ed00433fbeb2f16d5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "abd98e72c698e16a077443d29259f946f7ac36c6e5f5a6e172be5466c4cbf2cd"
  end

  # Last release on 2020-10-30 and needs EOL `pcre`
  deprecate! date: "2026-01-12", because: :unmaintained
  disable! date: "2027-01-12", because: :unmaintained

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pcre"

  def install
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
    system "./autogen.sh"

    # Fix compile with newer Clang
    # upstream bug report, https://github.com/dcjones/fastq-tools/issues/32
    if DevelopmentTools.clang_build_version >= 1403
      inreplace "configure" do |s|
        s.sub! "-Wall", "-Wall -Wno-implicit-function-declaration"
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    (testpath/"test.fq").write <<~EOS
      @U00096.2:1-70
      AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC
      +
      IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII0000000000
    EOS

    assert_match "A\t20", shell_output("#{bin}/fastq-kmers test.fq")
    assert_match "1 copies", shell_output("#{bin}/fastq-uniq test.fq")
  end
end
