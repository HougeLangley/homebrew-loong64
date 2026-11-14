class Renameutils < Formula
  desc "Tools for file renaming"
  homepage "https://www.nongnu.org/renameutils/"
  url "https://download.savannah.gnu.org/releases/renameutils/renameutils-0.12.0.tar.gz"
  sha256 "cbd2f002027ccf5a923135c3f529c6d17fabbca7d85506a394ca37694a9eb4a3"
  license "GPL-3.0-or-later"
  revision 3

  livecheck do
    url "https://download.savannah.gnu.org/releases/renameutils/"
    regex(/href=.*?renameutils[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, arm64_golden_gate: "90552510d43c1fe8644510114099b65d68141fa4e87e1fa427ce868faf3084fc"
    sha256 cellar: :any, arm64_tahoe:       "0fdd550dfb8a3ec4c7b30c22a6be8bf88104207328b51b7a3806b9f254e4eb85"
    sha256 cellar: :any, arm64_sequoia:     "93b6c0287a2a5222cc55484b0baa724174ac826afffc016f75165fdc0d37e6ea"
    sha256 cellar: :any, arm64_sonoma:      "9f28d9eb889603714cc5473541918196f60aab1e053791993ae53afd14c27926"
    sha256 cellar: :any, arm64_ventura:     "38109c05cfb9f8fcca3aeff270ad845937c1dd8677a74ea7fec3d717a3c722c9"
    sha256 cellar: :any, arm64_monterey:    "a6570746ef47eed43cbde686b8ebf162559a9ada031bab821064c5e0754135a8"
    sha256 cellar: :any, arm64_big_sur:     "0ea05fad50a7a43df09d3bbb652140e5037e91320ff9e549a9ad0cf41dfaa958"
    sha256 cellar: :any, sonoma:            "48bec726e452ee15d1d8e15ee14afb00ad95bf023fb94f38726fff6a1a7302fa"
    sha256 cellar: :any, ventura:           "75072c6cbce5f3a83176da9790df986e4d4dea99c6fc7c52f4b8d942c31c1026"
    sha256 cellar: :any, monterey:          "93a4fb65fd3bba13cd797f0c374981b8dde01ee25a0b0637f6e4448b655457e4"
    sha256 cellar: :any, big_sur:           "503b84eed8791b4a924e61fdfb0ea53cb6d349fe8a55c43ab7582c1e2a0985ba"
    sha256               arm64_linux:       "7e705d1e479f9c7c96ffe78fb84bb17f90897b130bb5e9b18699381fbd3de9f4"
    sha256               x86_64_linux:      "1a7ddae9fa3352ec89e73c91eaabedc5e941e3e752fdf5afda5b5098fb65cd7c"
  end

  depends_on "coreutils"
  depends_on "readline" # Use instead of system libedit

  conflicts_with "ipmiutil", because: "both install `icmd` binaries"

  # Use the GNU versions of certain system utilities. See:
  # https://trac.macports.org/ticket/24525
  # Patches rewritten at version 0.12.0 to handle file changes.
  # The fourth patch is new and fixes a Makefile syntax error that causes
  # make install to fail.  Reported upstream via email and fixed in HEAD.
  # Remove patch #4 at version > 0.12.0.  The first three should persist.
  patch do
    file "Patches/renameutils/0.12.0.patch"
    type :unofficial
  end

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
    # Work around build failure on Apple Silicon due to trying to use deprecated stat64.
    # io-utils.c:93:19: error: variable has incomplete type 'struct stat64'
    ENV["ac_cv_func_lstat64"] = "no" if Hardware::CPU.arm?

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-packager=Homebrew", *args, *std_configure_args
    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    ENV.deparallelize # parallel install fails
    system "make", "CFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration", "CXXFLAGS=-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    (testpath/"test.txt").write "Hello World!"
    pipe_output("#{bin}/icp test.txt", ".2\n")
    assert_equal File.read("test.txt"), File.read("test.txt.2")
  end
end
