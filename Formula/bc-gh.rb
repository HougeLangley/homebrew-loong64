class BcGh < Formula
  desc "Implementation of Unix dc and POSIX bc with GNU and BSD extensions"
  homepage "https://github.com/gavinhoward/bc"
  url "https://github.com/gavinhoward/bc/releases/download/7.0.3/bc-7.0.3.tar.xz"
  sha256 "91eb74caed0ee6655b669711a4f350c25579778694df248e28363318e03c7fc4"
  license "BSD-2-Clause"
  head "https://github.com/gavinhoward/bc.git", branch: "master"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5f217f49d45e07616875014f7a5c2f8ab101515d9f0ba6481fc77f430c8e2438"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "fa3bec57b187a0ccac9514b08d6782f93b7090917598f37c1f6bfa1ba21bcb9f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "9c25b6baed11d3e111039ea04100d211d37874750f42e2137d78e7774646e06b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "68e9138e7ca909ceffb94ef103feec58eb0c6fe84f315dc290ee3ad41597f163"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "60a78a50e4599775dd214f3c04662a918f0ca3ba7a4329e55334b8839f746bb1"
    sha256 cellar: :any_skip_relocation, sonoma:            "523f2085ce15b58bd77afc8324da625747be012b5706135c567d51a45ce906fb"
    sha256 cellar: :any_skip_relocation, ventura:           "ac2490db545515f79aea51d3433aa0bedef36f220fb0948851921c63cf5d82c9"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "c3c909b75dd473d2d9f9e7a266a485c23867721b4e1c08b41c68225ceccb5ac2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "99d223ee8690ef3a798c6c342faa78b304230ea30cb4957ce7e06b89fc213866"
  end

  keg_only :provided_by_macos # since Ventura

  depends_on "pkgconf" => :build

  uses_from_macos "libedit"

  conflicts_with "bc", because: "both install `bc` and `dc` binaries"

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
    # https://github.com/gavinhoward/bc#recommended-optimizations
    ENV.O3
    ENV.append "CFLAGS", "-flto"

    # NOTE: `--predefined-build-type` should be kept first to avoid overwriting later args
    system "./configure.sh", "--predefined-build-type=GNU",
                             "--disable-generated-tests",
                             "--disable-problematic-tests",
                             "--disable-nls",
                             "--enable-editline",
                             "--prefix=#{prefix}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system bin/"bc", "--version"
    assert_match "2", pipe_output(bin/"bc", "1+1\n", 0)
  end
end
