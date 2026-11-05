class Tth < Formula
  desc "TeX/LaTeX to HTML converter"
  homepage "http://silas.psfc.mit.edu/tth/"
  url "https://downloads.sourceforge.net/project/tth/tth4.16.tar.gz"
  sha256 "b0e118d49a37e06598c1e2b524ea352ceabf064afef25acf02b556229ee43512"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    regex(%r{url=.*?/tth[._-]?v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "06963633191d990f5f72bb63fb68b2a2488fe7be56eb082453cc87c0c695cc49"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "78e1ec7d5be8797a77a217fcc2554a1449311cd638fba7ef1f3c9a706c50f027"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "9de28731b96776948549eece755898c358e0df99e6078f8b6eb07baaa489efd9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "85bba0ec3b07964610a39b5686c62e7ccb25a058b8883184061aaffe3fa55306"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "8a630245be3f0b2b1f83a21d6af1525ee257d6211bc1c6845e31ab398eae6767"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "2e2fb5e9595c2687fecaf6a24da03d4a97c53ed99621750aa9d76f66e6bd7271"
    sha256 cellar: :any_skip_relocation, sonoma:            "567e126bb0a4f62da3051a005a9490d240d9c3d335c5998914e10c9ea991b29d"
    sha256 cellar: :any_skip_relocation, ventura:           "8715b445b87dd7f4363ac369d328eb62a3777029052f20340f4d82f46258f2ed"
    sha256 cellar: :any_skip_relocation, monterey:          "2f3a06677f7f7f9267f37ad78c748b4809e6f10e61cb53804ed712cd94631d9f"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "0e4122efc9e5e4ae81a404ef164a420fe399d9b13d761f7805876a0f1078aeb5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "d23d9a3cb16bbbd398fef5f4ed527bfcdbe5708ff653056ea1b3bdf7217783bd"
  end

  uses_from_macos "flex" => :build

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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types " }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "tth.c"
    system ENV.cc, *_extra, "-o", "tth", "tth.c"
    bin.install %w[tth latex2gif ps2gif]
    man1.install "tth.1"
  end

  test do
    assert_match(/version #{version}/, pipe_output(bin/"tth", ""))
  end
end
