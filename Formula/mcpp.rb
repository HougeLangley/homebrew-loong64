class Mcpp < Formula
  desc "Alternative C/C++ preprocessor"
  homepage "https://mcpp.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mcpp/mcpp/V.2.7.2/mcpp-2.7.2.tar.gz"
  sha256 "3b9b4421888519876c4fc68ade324a3bbd81ceeb7092ecdbbc2055099fcb8864"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(%r{url=.*?/mcpp[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any,                 arm64_golden_gate: "272aa5149c2d8fc642be75df9a03515d090453110ca16a88312090c331436fd2"
    sha256 cellar: :any,                 arm64_tahoe:       "f3678576a7e9a2007227897d1617aba79b3ace1340c0a5e77b1bcfff43da38c3"
    sha256 cellar: :any,                 arm64_sequoia:     "37f98fe44da635f01775091f8196d3eacb4b9dfcab22b5702488714ea4599cba"
    sha256 cellar: :any,                 arm64_sonoma:      "42c256dc7e6f9d09f12de8bf97cc1988d020931cc7471c8ae9402b35d57748f7"
    sha256 cellar: :any,                 arm64_ventura:     "1c08275021d44b1db481d2f802ce2b69da952ea4afe04e1a0ce9ae36243f08f1"
    sha256 cellar: :any,                 arm64_monterey:    "506e27459d6f4f9fc296bcf826d113aaa659fc814f11419fa484bf38ec94888d"
    sha256 cellar: :any,                 arm64_big_sur:     "b6b90e4e5f4b50a390a5cbd6d2c6664dd8d3212013e469c9d3c90d5bf67a774c"
    sha256 cellar: :any,                 sonoma:            "94b52de3f8d1a6023e83f10cb82fd00d8c3284a971b6f04ae48d8f0584180971"
    sha256 cellar: :any,                 ventura:           "69aad3cd745bb5fb369475a44ac532848d2cedee77a832552cff37f522b19469"
    sha256 cellar: :any,                 monterey:          "fb4dbfea519b3df6d1b10a769ac1f25f53fccda42d2112602a9dcd2eee7bd791"
    sha256 cellar: :any,                 big_sur:           "ba1468299782ecb1de53cff2390096e7300f5c8f021cef623544d969a37240df"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "e3b5ff7ba12b3476bfdbc98e83a6aefb67ccee2a96201ac521baa85389585e73"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "7869ff9d2c9946dd38a7891ea70766983208df755ca0f206016211b3239701c8"
  end

  # stpcpy is a macro on macOS; trying to define it as an extern is invalid.
  # Patch from ZeroC fixing EOL comment parsing
  # https://forums.zeroc.com/discussion/5445/mishap-in-slice-compilers
  patch do
    file "Patches/mcpp/2.7.2.patch"
  end

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
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    # expand.c:713:21: error: assignment to 'char *' from
    # incompatible pointer type 'LOCATION *' {aka 'struct location *'}
    ENV.append_to_cflags "-Wno-error=incompatible-pointer-types"

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-mcpplib", *args, *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    # fix `warning: Unknown encoding: C.utf8`
    ENV["LC_ALL"] = "en_US.UTF-8"

    (testpath/"test.c.in").write <<~C
      #define RET 5
      int main() { return RET; }
    C

    (testpath/"test.c").write shell_output("#{bin}/mcpp test.c.in")
    system ENV.cc, *_extra, "test.c", "-o", "test"
    assert_empty shell_output("./test", 5)
  end
end
