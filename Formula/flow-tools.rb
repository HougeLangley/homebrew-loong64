class FlowTools < Formula
  desc "Collect, send, process, and generate NetFlow data reports"
  homepage "https://code.google.com/archive/p/flow-tools/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/flow-tools/flow-tools-0.68.5.1.tar.bz2"
  sha256 "80bbd3791b59198f0d20184761d96ba500386b0a71ea613c214a50aa017a1f67"
  license "BSD-2-Clause"

  bottle do
    rebuild 2
    sha256 arm64_golden_gate: "02f9410f5e51f89d34bae9d26b11fff87890c45003f33114d044e513011aa520"
    sha256 arm64_tahoe:       "c6ac8dfec95def2a25acdf33db6ddd896f473f64c402e415753a316d0eef78b1"
    sha256 arm64_sequoia:     "7e2efd253c92894d3d2a423bc535eb5fea7a8507b677e1346e14cd6cc925aef9"
    sha256 arm64_sonoma:      "9e5dafcea86e53dc7e880dd4f4a978563e4e5abb7ab226386fca7f1afd40203d"
    sha256 sonoma:            "9d5da70fb239297657612492fd4448ec29ebd54612fc2e3fc77db0d0802fece5"
    sha256 arm64_linux:       "86b056849f21682bd1cb1c180e5df2e62790f79717c27f2cc2bd4d09ef3019be"
    sha256 x86_64_linux:      "6ea0a8b997faf61a95f480149b697f9ee4446674e12bf5deaf34c132a1e314e8"
  end

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  # Apply Fedora patch to fix implicit function declarations and multiple definitions
  patch do
    url "https://src.fedoraproject.org/rpms/flow-tools/raw/5590477b99c33b61a4d18436453a29e398be01aa/f/flow-tools-c99.patch"
    sha256 "ce1693d53c1dab3a91486a8005ea35ce35a794d6b42dad2a4e05513c40ee9495"
    type :unofficial
  end
  patch do
    url "https://src.fedoraproject.org/rpms/flow-tools/raw/61ed33ab67251599c26a2e2636f1926b0448ab8a/f/flow-tools-extern.patch"
    sha256 "3b0937004edfabc53d966e035ad2a2c3239bcfccdc1bacef2f54612fccd84290"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lfl"
    ENV.append "LDFLAGS", "-lfl"
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
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "-DCMAKE_CXX_FLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"].freeze
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
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "LIBS=-lfl", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make", "LIBS=-lfl", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    # Generate test flow data with 1000 flows
    data = shell_output("#{bin}/flow-gen")
    # Test that the test flows work with some flow- programs
    pipe_output("#{bin}/flow-cat", data, 0)
    pipe_output("#{bin}/flow-print", data, 0)
    pipe_output("#{bin}/flow-stat", data, 0)
  end
end
