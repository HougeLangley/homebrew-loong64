class Digitemp < Formula
  desc "Read temperature sensors in a 1-Wire net"
  homepage "https://www.digitemp.com/"
  url "https://github.com/bcl/digitemp/archive/refs/tags/v3.7.2.tar.gz"
  sha256 "683df4ab5cc53a45fe4f860c698f148d34bcca91b3e0568a342f32d64d12ba24"
  license "GPL-2.0-or-later"
  head "https://github.com/bcl/digitemp.git", branch: "master"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "14c832ef6798a9399d82f96e1193bb8272781a86ffea4715a2c580741e4a81a4"
    sha256 cellar: :any,                 arm64_golden_gate: "d0c954465b8cab92a8204875ff6daa4d47c8e3f6cfe98d7c6ed2e099035b9fc5"
    sha256 cellar: :any,                 arm64_tahoe:       "4814840607f10a9305f0840e3d93bf5a5ef4c050c4f3d11dc624a9c66df7ac58"
    sha256 cellar: :any,                 arm64_sequoia:     "e807829f6b24e85e3cb39c442aff3b400d886b16b6a17b7122df5b3ec9a92bc1"
    sha256 cellar: :any,                 arm64_sonoma:      "745ab5f0bd70e480714242d647e99eb37b290c0e308f942aad4753dd4efa53ad"
    sha256 cellar: :any,                 arm64_ventura:     "90f8b147176e4c1383934ed0992b8647b6d31f80069c6bb0803928f653911f88"
    sha256 cellar: :any,                 arm64_monterey:    "8de47e480d9a46e00ca897acad3787f7c6897aefe28e63f3008aa7c736112e17"
    sha256 cellar: :any,                 arm64_big_sur:     "d63a759441dd683b447bc9db45786b1bce2f662d67a340d81048b8a25daa021f"
    sha256 cellar: :any,                 sonoma:            "dbae73b02c4201fecf961c3dcd1276d34e9f636a8c23815ebcd60775a2a9d103"
    sha256 cellar: :any,                 ventura:           "0c886d16a9413d8639d8c970ac6d875b1a63ae5585a44e67086262d2f310331a"
    sha256 cellar: :any,                 monterey:          "b184352eb21cbca65269b7b0ae3da2213791b53530f515c91a0edc44a37d0534"
    sha256 cellar: :any,                 big_sur:           "dfcce60792d55b3d715c7cadb3179193ce943edb291913423c34456b53a1ac37"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "0356ddcd980cc160525986977c05d35786c47e42bc2ed992e2cbf7432f3d1077"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "3f307cb2ce339c2b19089b46fc564e4492126b75abea1c79ca31fe6debfa5341"
  end

  depends_on "libusb-compat"

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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types" }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    mkdir_p "build-serial/src"
    mkdir_p "build-serial/userial/ds9097"
    mkdir_p "build-serial/userial/ds9097u"
    mkdir_p "build-usb/src"
    mkdir_p "build-usb/userial/ds2490"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "-C", "build-serial", "-f", "../Makefile", "SRCDIR=..", "ds9097", "ds9097u"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "-C", "build-usb", "-f", "../Makefile", "SRCDIR=..", "ds2490"
    bin.install "build-serial/digitemp_DS9097"
    bin.install "build-serial/digitemp_DS9097U"
    bin.install "build-usb/digitemp_DS2490"
    man1.install "digitemp.1"
    man1.install_symlink "digitemp.1" => "digitemp_DS9097.1"
    man1.install_symlink "digitemp.1" => "digitemp_DS9097U.1"
    man1.install_symlink "digitemp.1" => "digitemp_DS2490.1"
  end

  # digitemp has no self-tests and does nothing without a 1-wire device,
  # so at least check the individual binaries compiled to what we expect.
  test do
    assert_match "Compiled for DS2490", shell_output("#{bin}/digitemp_DS2490 2>&1", 255)
    assert_match "Compiled for DS9097", shell_output("#{bin}/digitemp_DS9097 2>&1", 255)
    assert_match "Compiled for DS9097U", shell_output("#{bin}/digitemp_DS9097U 2>&1", 255)
  end
end
