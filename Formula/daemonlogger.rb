class Daemonlogger < Formula
  desc "Network packet logger and soft tap daemon"
  homepage "https://sourceforge.net/projects/daemonlogger/"
  url "https://downloads.sourceforge.net/project/daemonlogger/daemonlogger-1.2.1.tar.gz"
  sha256 "79fcd34d815e9c671ffa1ea3c7d7d50f895bb7a79b4448c4fd1c37857cf44a0b"
  license "GPL-2.0-only"

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_golden_gate: "fcb4eddd57951cc15c4efe8c9ade79a5334b4586b68c849a49e69075da23d1d4"
    sha256 cellar: :any,                 arm64_tahoe:       "0ced73ca63e8d048dbc4692cbadf68f13d834fb8e5bf642be31d4573d58d17bb"
    sha256 cellar: :any,                 arm64_sequoia:     "0be691de00ba4892bb91171da20c25ed0d3bda987d6d7345b35e095d06b8b848"
    sha256 cellar: :any,                 arm64_sonoma:      "d6fae15e4986a7f8046ff53a00d64927c225c75a03741c491b2a8bbd9c87f8f2"
    sha256 cellar: :any,                 arm64_ventura:     "beee453bd9b0404bd4a145fb466eaf3ed8212d24570bc4eb0fa5480cda06c4c9"
    sha256 cellar: :any,                 arm64_monterey:    "5df034d135e6be79eee9c27f0b53cc1b9531b8d027c40f6e7c9b76561a0476d6"
    sha256 cellar: :any,                 arm64_big_sur:     "cebaf67384c1d536a827bd4da514b70f2342315cfc013fa3e0e9fd0c658c22a4"
    sha256 cellar: :any,                 sonoma:            "7a5a4ce158ed37a04fb7fb7bd1fae312eb4e212eb795f78a63826b8ff40e38e7"
    sha256 cellar: :any,                 ventura:           "f85bf445ce68b5ab5914671739bebfe81ed91f7ee0bed9d4e92667e42edf6c5e"
    sha256 cellar: :any,                 monterey:          "1c2f08e5d06fd71339d5f2c3f730b2e15ef60ceee56c23efa98026f65ec94954"
    sha256 cellar: :any,                 big_sur:           "37a025cbb7898243913ad07bb094b2195e27587b5458d465fea790d30f13af67"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "f113a27d6f67fb9de34fd6b13d6736aa466df7d0d6d9eb91c21446937500b596"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "462b6ecbf94169210be2591de29de97b69a701cc810485fb956bf7892e1b57fa"
  end

  depends_on "libdnet"

  uses_from_macos "libpcap"

  deny_network_access!

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
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
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
    system bin/"daemonlogger", "-h"
  end
end
