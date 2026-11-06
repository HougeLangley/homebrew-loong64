class Libidl < Formula
  desc "Library for creating CORBA IDL files"
  homepage "https://download.gnome.org/sources/libIDL/0.8/"
  url "https://download.gnome.org/sources/libIDL/0.8/libIDL-0.8.14.tar.bz2"
  sha256 "c5d24d8c096546353fbc7cedf208392d5a02afe9d56ebcc1cccb258d7c4d2220"
  license "LGPL-2.0-or-later"
  revision 1

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "a6d3733db277d7b88157c0119017434baf2e94a93d22716ce307ec6c1e454caa"
    sha256 cellar: :any,                 arm64_tahoe:       "a0e91391470fe336c418566901c022fbd51387a87581ac820e72592c561001d7"
    sha256 cellar: :any,                 arm64_sequoia:     "dc9090a7f3672741f6edaa0564cc8c5cb28cb24e4bc43108d8953e05f3fb1eaf"
    sha256 cellar: :any,                 arm64_sonoma:      "555fa331e45efaead26f0b6ff68fd41f1a75223a68e5469fa041f4bb95676ad0"
    sha256 cellar: :any,                 arm64_ventura:     "c0d6a80577aeb880b24d8ec60c11a5f4e49e48ee5109e6a4dbbcfca24b2a05f3"
    sha256 cellar: :any,                 arm64_monterey:    "84968b36ff2cb712d57470b45200c7b421e2e86f60a018829534a971856f3a9c"
    sha256 cellar: :any,                 arm64_big_sur:     "8b4d33f25fe4a01c6924b42d64072cbf42ca133552e67d47c46412ca2e848867"
    sha256 cellar: :any,                 sonoma:            "6ae268a8434298d17350ca586154a01082dfa7a7b1dc0028c8da599ca453132b"
    sha256 cellar: :any,                 ventura:           "b709339fadfbdae39d0698c331e1f92d32b077c0cf60d8ceff0ea05c906b9511"
    sha256 cellar: :any,                 monterey:          "9b0791153103e3a4629804b46bccc3829d17bfcead908916cac480ba624b3a6e"
    sha256 cellar: :any,                 big_sur:           "320ddc04b68934e51f31fc33223c11097d712869a83242ca6669d05ca112ede9"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "57eeee9bf85e175fcdbd07db76bafa970051cf061836efd715957e5cfcb7319a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "9ede5070565f89d3e7f24f01d9da73d50b6c008fbf12f7247d3cd04b8076d842"
  end

  depends_on "gettext" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "glib"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_macos do
    depends_on "gettext"
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
    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libIDL/IDL.h>
      int main(void) {
        return 0;
      }
    C

    pkg_config_flags = shell_output("pkg-config --cflags --libs libIDL-2.0").chomp.split
    system ENV.cc, *_extra, "test.c", *pkg_config_flags, "-o", "test"
    system "./test"
  end
end
