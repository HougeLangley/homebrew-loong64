class Libowfat < Formula
  desc "Reimplements libdjb"
  homepage "http://www.fefe.de/libowfat/"
  url "https://deb.debian.org/debian/pool/main/libo/libowfat/libowfat_0.34.orig.tar.xz"
  mirror "http://www.fefe.de/libowfat/libowfat-0.34.tar.xz"
  sha256 "d4330d373ac9581b397bc24a22ad1f7f5d58a7fe36d9d239fe352ceffc5d304b"
  license "GPL-2.0-only"
  head ":pserver:cvs:@cvs.fefe.de:/cvs", using: :cvs

  livecheck do
    url :homepage
    regex(/href=.*?libowfat[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b7adf30d6fb1dc1a586f8b504251c094e7240637c7e44bb29b101367d727d025"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "bc30d254df3bcd360e4f3171d2afc99997cadfec8fd46a90f2c56991677ee87b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c3846b7776a5350100cf8a734e0a45fcbe822f53128ab88bce24cfb259b3d27c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "60f9182c837f2b6ff6a79e76e7c4965c717055448b3c2928baf297fd944c3035"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "b9f9d4615bb4f889dad22f8b880d2e197a7fb0caa7f48d20acb459ad868635d2"
    sha256 cellar: :any_skip_relocation, sonoma:            "a0c8d5df1d6c01a6d36098ad87a856d8a223df535e5829ada59ecde849e54bd4"
    sha256 cellar: :any_skip_relocation, ventura:           "7f442fd43af0708854473e6c97e5da531f8b1605180bc237e815beae3e40cf55"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "17c1d34c4f362a68196eef92ec8d8621a4af98d94e5120a637cca1c987f20bd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "9033e9d8c499e2a37af9a3b0110206e494306bbc855e7e9d16d3cd3adf291801"
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration" }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    system "make", "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "libowfat.a"
    system "make", "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install", "prefix=#{prefix}", "MAN3DIR=#{man3}"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libowfat/str.h>
      int main()
      {
        return str_diff("a", "a");
      }
    C
    system ENV.cc, *_extra, "test.c", "-I#{include}", "-L#{lib}", "-lowfat", "-o", "test"
    system "./test"
  end
end
