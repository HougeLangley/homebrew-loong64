class Utimer < Formula
  desc "Multifunction timer tool"
  homepage "https://launchpad.net/utimer"
  url "https://launchpad.net/utimer/0.4/0.4/+download/utimer-0.4.tar.gz"
  sha256 "07a9d28e15155a10b7e6b22af05c84c878d95be782b6b0afaadec2f7884aa0f7"
  license "GPL-3.0-or-later"
  revision 1

  livecheck do
    skip "No longer developed or maintained"
  end

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "a2a68ca41e5f9dca77f057b66945e8e59e360d2fe289b6618b41dd90b9585863"
    sha256 cellar: :any,                 arm64_tahoe:       "e23eb9898bf6490db8dab00ca39f6c2b2e90fd358c3049e1f36a0c637ca06b6c"
    sha256 cellar: :any,                 arm64_sequoia:     "b81fca5d55f6c336477ac27ce66e9fb030be982864b54be675ee624b73444f7b"
    sha256 cellar: :any,                 arm64_sonoma:      "ee04213e439d3e859b16c5f0e07f19d70400a9dea3bcde536212cee288bfb6f6"
    sha256 cellar: :any,                 arm64_ventura:     "f4b18b839f3d9864738ba4e120852b0d3fae8d67c7d98b4ce370a89a9eb839ec"
    sha256 cellar: :any,                 arm64_monterey:    "3c86234c30c090ef832ddfb4c4b52117f6ef31956246abb311645860154cc6fc"
    sha256 cellar: :any,                 arm64_big_sur:     "bb50ed1a38ea9dc66c442261dbf8f6e517b9d374869e647d2136c580a47f7aca"
    sha256 cellar: :any,                 sonoma:            "db50a4407088f9b9e67399934093cfd7fd5e703658176f07264f1555c9a42300"
    sha256 cellar: :any,                 ventura:           "ee2b3d29f6278e6a0195e0fccc6a787eb610a1b882960aad227a94ddcf19e6c8"
    sha256 cellar: :any,                 monterey:          "8f1bc7e7ea1445618ce50bfcc7c8aea1570ea70245d17e47b4ac7d9d6d68e295"
    sha256 cellar: :any,                 big_sur:           "35c830b5c976738af7451ff1d110028a351e1b16145efa54ba0d042ff43e8980"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "afd0dd70f2d6382759333b763d794b5f309ecb15f48e5228f4df6c00787414f2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "a44f6b1ef51bbbb0a61411585f06bc0d7e9d94083b04c11802f26ba2b2f36d8e"
  end

  depends_on "gettext" => :build
  depends_on "intltool" => :build
  depends_on "pkgconf" => :build
  depends_on "glib"

  uses_from_macos "perl" => :build

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    depends_on "perl-xml-parser" => :build
  end

  def install
    # conf-cc 追加（djb 风格：compile 脚本从 conf-cc 读编译器）
    %w[conf-cc conf-cxx].each do |cf|
      next unless File.exist?(cf)
      _c = File.read(cf).strip
      File.write(cf, _c + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h\n") unless _c.include?("gnu17")
    end
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h", "-DCMAKE_CXX_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h"].freeze
    # ENV.cc 追加
    _extra = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h".split
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h " }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h"
    # Work around /usr/bin/ld: timer.o:(.bss+0x0): multiple definition of `ut_config'
    ENV.append_to_cflags "-fcommon" if OS.linux?
    # Fix compile with newer Clang. Project is no longer maintained so cannot be fixed upstream.
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "./configure", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -fcommon -include locale.h",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    assert_match "Elapsed Time:", shell_output("#{bin}/utimer -t 0ms")
  end
end
