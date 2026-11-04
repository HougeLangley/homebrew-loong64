class Gemmi < Formula
  desc "Macromolecular crystallography library and utilities"
  homepage "https://project-gemmi.github.io/"
  url "https://github.com/project-gemmi/gemmi/archive/refs/tags/v0.7.5.tar.gz"
  sha256 "9e2a8a51e62c69bf43f62aadf527ca4312860de8a36c12a8747d3e8ae556f0b3"
  license "MPL-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any, arm64_golden_gate: "af7c76cd39c839899b27f43d101e2ba59680d4567b6d3824986fb5f7b9833bb0"
    sha256 cellar: :any, arm64_tahoe:       "3dc2a4467fa0ed0928090f9cd53ef636ef03dd68902a1922d298e09b992f6c4a"
    sha256 cellar: :any, arm64_sequoia:     "2077899d6278a7f1ca8ccb53baafdf1b99eb9b236ac8564ac2c4920043941f55"
    sha256 cellar: :any, arm64_sonoma:      "a2c1dbcb81cbed37589504edb8e0191e12493a2f1f0780b988aba084623c39d4"
    sha256 cellar: :any, sonoma:            "f73c874975cd7286f5cc420129ad7db5996e8aee21fd7b8efb3a336ab04c1dba"
    sha256 cellar: :any, arm64_linux:       "7c00d4a2c478413c35c00072b362568ffe153089e8ba2f60a7ecf69ccf4336ab"
    sha256 cellar: :any, x86_64_linux:      "9ffa4d84b28bb74552a6b0ed7eef9b26cad33b46b403a8cded4a7e927e1e8b64"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # cc 命令改写（Makefile 里写死 cc 而非 $(CC) 时）
    Dir["Makefile", "**/Makefile", "**/GNUmakefile", "**/Makefile.*"].each do |mkf|
      next unless File.exist?(mkf)
      _m = File.read(mkf)
      _m = _m.gsub(/^(	| {0,4})(cc|gcc)([ 	])/) { "#{$1}$(CC)#{$3}" }
      File.write(mkf, _m)
    end
    # CMake 标志追加
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -Dstbsp__uintptr=stbsp__uint64", "-DCMAKE_CXX_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -Dstbsp__uintptr=stbsp__uint64"].freeze
    # ENV.cc 追加
    _extra = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -Dstbsp__uintptr=stbsp__uint64".split
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -Dstbsp__uintptr=stbsp__uint64" }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -Dstbsp__uintptr=stbsp__uint64' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types -Dstbsp__uintptr=stbsp__uint64"
    system "cmake", "-S", ".", "-B", "build", *_cmflags, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    pkgshare.install "tests"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gemmi --version")

    system bin/"gemmi", "validate", pkgshare/"tests/misc.cif"
  end
end
