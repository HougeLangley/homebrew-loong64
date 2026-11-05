class Ttyrec < Formula
  desc "Terminal interaction recorder and player"
  homepage "http://0xcc.net/ttyrec/"
  # Upstream is only available via HTTP, so we prefer Debian's HTTPS mirror
  url "https://deb.debian.org/debian/pool/main/t/ttyrec/ttyrec_1.0.8.orig.tar.gz"
  mirror "http://0xcc.net/ttyrec/ttyrec-1.0.8.tar.gz"
  sha256 "ef5e9bf276b65bb831f9c2554cd8784bd5b4ee65353808f82b7e2aef851587ec"
  license "BSD-4-Clause"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7bccb91351464d139b2079395a92dde828f15532b761a9a801ae21cd684ba1e6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "2b44b170e50cd4a45a34866f55c074aa7178b26a733350d471dff58709831cf0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "1bc483dbae460cdc63985077a07ab767d1f3b3b2d614ef276a038a07bbaa479c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "d151676ce6f3761eb16f59d01ebfc1504d63477695f5b5c8d178a0d5c095139a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "8da60792e0827bc948f8f1f0ce1f4c2e223e987c62943e8d854887d2b3557de4"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "3ae3690abbab9b59cd40c4a0004f21c5277c5642484fed77c180115030fa637e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "5538f4c65b9395dd35a7d9f975a7da59a9e9b1bc4cf09725b86d61c48755306a"
    sha256 cellar: :any_skip_relocation, sonoma:            "0e9bd8f7c2282ae05b62d8e632eca528d483830ecaadd072d8fa9de280720585"
    sha256 cellar: :any_skip_relocation, ventura:           "e9de3489dab176b7c6335e02bf2e58dbc83a31687a714af08ec3a4c4d5cd4be1"
    sha256 cellar: :any_skip_relocation, monterey:          "2e9366729fa85940745e55645c77c6f22c2ba47ad356159e5fc5564988e88e0b"
    sha256 cellar: :any_skip_relocation, big_sur:           "dc7756b323c5faf2006093ac2873d7805f5ddfc06df6bf5bcbcdd4fa70b2c328"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "ea3a96ddfe71319d95009cd84257f98d42a335e692aea071b9d9a718e2d58a89"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "2dd1acdb4519d34c1b28fced057623dcd6457c60def91150fd042ed6be04e481"
  end

  # Last release on 2006-06-11
  deprecate! date: "2026-07-17", because: :unmaintained
  disable! date: "2027-01-17", because: :unmaintained

  conflicts_with "ovh-ttyrec", because: "both install the same binaries"

  # Fixes "ttyrec.c:209:20: error: storage size of ‘status’ isn’t known";
  # check `man 2 wait3`.
  patch :DATA

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
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    # macOS has openpty() in <util.h>
    # Reported by email to satoru@0xcc.net on 2017-12-20
    inreplace "ttyrec.c", "<libutil.h>", "<util.h>" if OS.mac?

    # openpty is a BSD function
    ENV.append_to_cflags "-DHAVE_openpty" if OS.mac?

    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "CFLAGS=#{ENV.cflags}"
    bin.install %w[ttytime ttyplay ttyrec]
    man1.install Dir["*.1"]
  end

  test do
    (testpath/"test.tty").binwrite([0, 0, 4].pack("V3") + "test" + [9, 0, 3].pack("V3") + "end")

    assert_equal "9\ttest.tty", shell_output("#{bin}/ttytime test.tty").strip
  end
end

__END__
--- a/ttyrec.c
+++ b/ttyrec.c
@@ -203,11 +203,7 @@ doinput()
 void
 finish()
 {
-#if defined(SVR4)
 	int status;
-#else /* !SVR4 */
-	union wait status;
-#endif /* !SVR4 */
 	register int pid;
 	register int die = 0;
 
