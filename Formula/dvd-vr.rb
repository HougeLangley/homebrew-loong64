class DvdVr < Formula
  desc "Utility to identify and extract recordings from DVD-VR files"
  homepage "https://www.pixelbeat.org/programs/dvd-vr/"
  url "https://www.pixelbeat.org/programs/dvd-vr/dvd-vr-0.9.7.tar.gz"
  sha256 "19d085669aa59409e8862571c29e5635b6b6d3badf8a05886a3e0336546c938f"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?dvd-vr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "61cb88d905a258268103373e2ba2270eda1e3cec086f4ed00e3a6d677a119a50"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "c866d88cd9c2d24675c6adb25ea1b78fc4139e15d46ce14e652e1302c99137f9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "7ec179b825a5afc971de1205ec65943227d9c09257a16558a068bc47c024887d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "553619321e617365b7e1a3f3dbb678840ac7824eb6424b5dc484ee75b8512639"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "f134891dbbb4f74aa606a2f560ae6992764387c39e8d92977828d1983f04e575"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "09d9566df3e194af10ca708f99f20d0d7ca0f2d14dae84c797508c443cd5fb8e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "34cfb579dcddb0ded88010dea55a3b5bb4d78628ab6c0bc0e7f70d93882b2156"
    sha256 cellar: :any_skip_relocation, sonoma:            "3062abb991148622f0b45f7ee8e7aab766c9ad95c1c83420a201a72c335f7f59"
    sha256 cellar: :any_skip_relocation, ventura:           "fd4bf8df87ae39182a966d3f85daa450777ad8e1f2a247a64309a0045246a244"
    sha256 cellar: :any_skip_relocation, monterey:          "8374a6b1aee80538c9b31d48edb0065deb63fb3bfdcea4e62b206818cbb7f181"
    sha256 cellar: :any_skip_relocation, big_sur:           "4c1ab9eca5fcff27e5aa6185a9b908c1c4c0569ceede8ef574d8365da6f1d914"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "9d552a1d306c8a6f7ba249914385d89c1294e0b54b2aa5aced30e72504396b03"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "64fbe6463814cb9fa4e34863bebe256e8973abeb1241f299173ae409c00da770"
  end

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"dvd-vr", "--version"
  end
end
