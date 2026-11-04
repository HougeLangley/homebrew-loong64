class Dcled < Formula
  desc "Linux driver for dream cheeky USB message board"
  homepage "https://www.jeffrika.com/~malakai/dcled/index.html"
  url "https://www.jeffrika.com/~malakai/dcled/dcled-2.2.tgz"
  sha256 "0da78c04e1aa42d16fa3df985cf54b0fbadf2d8ff338b9bf59bfe103c2a959c6"
  license :cannot_represent

  livecheck do
    url :homepage
    regex(/href=.*?dcled[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_golden_gate: "fe7447f65ad20dfac54a0586442e480ed2f3f9f1e3150bd596c79028c01b15b0"
    sha256 cellar: :any,                 arm64_tahoe:       "5369329587a6c3ec28976ebbd89fc4f8361b2472e38ee6518ebdf95dc04cddd1"
    sha256 cellar: :any,                 arm64_sequoia:     "1e3b757bcbd17baa0865903e7639f2bdeede51da0e38b5859047810ec34ae39b"
    sha256 cellar: :any,                 arm64_sonoma:      "3cf40a7a9200cbfd9e23603df8f307172f6858dabf1ced162d4ce2e5fac039dd"
    sha256 cellar: :any,                 arm64_ventura:     "4ac7c81b9155f3196eccb25a230494545976a8570e91fe9c5e6544e5e860be92"
    sha256 cellar: :any,                 arm64_monterey:    "338db9a99977a15fec8a4e2c2bf4432150c21e13e570c1caa852b99a689a9b3b"
    sha256 cellar: :any,                 arm64_big_sur:     "bd8fb1848c3296e5eaadf1436f891a2a6ab8142135947a2806db1d2e5212695d"
    sha256 cellar: :any,                 sonoma:            "6f565465c16d2a490c1f0beb0c6dd483c156102cde2a8bf3b58a41bd84bb194e"
    sha256 cellar: :any,                 ventura:           "42bb46504f3936e2e6698f4a7da7e7de0db98a2edb55fa83ce91ff8c238c1cbd"
    sha256 cellar: :any,                 monterey:          "65cd5df08d1292e7f046bcada635cfd63708fcf75f7cc4e9f23b3bb402e0bbc1"
    sha256 cellar: :any,                 big_sur:           "5c36acee3c790871237cb7a3400c6fe4e37daa90258c10b89043ac2aad3a6dc4"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "6e3b1302c4e78c0539f141a055e2df647c9c4ed4e8f4010c808e7e42163fe741"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "c0c7a6b33e48eb8e369235f0bd1e84d10c161a41eaec0ab93854bec94df8aee0"
  end

  depends_on "libusb"

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
    # Fix compile with newer Clang
    if DevelopmentTools.clang_build_version >= 1403
      inreplace "Makefile", "-Wunused-variable", "-Wunused-variable -Wno-implicit-function-declaration"
    end

    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "CC=#{ENV.cc} -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",
                   "LIBUSB_CFLAGS=-I#{formula_opt_include("libusb")}/libusb-1.0"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install",
                   "FONTDIR=#{share}/#{name}",
                   "INSTALLDIR=#{bin}"
  end

  test do
    system bin/"dcled", "--help"
  end
end
