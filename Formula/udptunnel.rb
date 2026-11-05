class Udptunnel < Formula
  desc "Tunnel UDP packets over a TCP connection"
  homepage "https://www.cs.columbia.edu/~lennox/udptunnel/"
  url "https://www.cs.columbia.edu/~lennox/udptunnel/udptunnel-1.1.tar.gz"
  mirror "https://pkg.freebsd.org/ports-distfiles/udptunnel-1.1.tar.gz"
  sha256 "45c0e12045735bc55734076ebbdc7622c746d1fe4e6f7267fa122e2421754670"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?udptunnel[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5d94051d663c0cec3c8d783017524a12cb09d659f829eb9aa286f9b80a18dd85"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "955432103c2a78902e1560848604ef6aff9513feef9603f1f6ff10235136e8a2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "be4c5ad4d4094dd6afe8d22aa7ab5fad4a53ca8605a4d9c8b379f209076fe48b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "68d39772c6215367e95610b65557e2055741cc6f1647f0c203ecb1e2bef0a617"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "41ccbefe035c6cb8d7cb3a1aaec9421819c18d02f909b296c8751ee541aa585d"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "dbb91d06c314bf6dea17191505ba382300f7a5b8551c973d79f516ba769153a6"
    sha256 cellar: :any_skip_relocation, sonoma:            "f6d79761a7e95026828863a9ac3b4446603008c36610b651d2ad2b2a73e3110b"
    sha256 cellar: :any_skip_relocation, ventura:           "8f92018d640442578d0d26e06ea3893666da7847cb88acf76ef3dd6530f55397"
    sha256 cellar: :any_skip_relocation, monterey:          "b81e584e4ed1d6e579829e55488fe8ff398862d36f0619867b94ec4fbf6d1f61"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "eb84b77db4dc77640e9ed18c024af27dd1557dc6f4ec00acd374791a2f461664"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "af4f9f7bf957a343e94d7dfeb746dd2a6bcf80e9f6689fcb083d281494f75ac7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  on_linux do
    depends_on "libnsl"
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types " }
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
      _cfg = _cfg.gsub(/^CFLAGS="([^"\\]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1200

    ENV["LIBS"] = "-L#{formula_opt_lib("libnsl")}" if OS.linux?

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
    doc.install "udptunnel.html"
  end

  test do
    assert_equal <<~EOS, shell_output("#{bin}/udptunnel -h 2>&1", 2)
      Usage: #{bin}/udptunnel -s TCP-port [-r] [-v] UDP-addr/UDP-port[/ttl]
          or #{bin}/udptunnel -c TCP-addr[/TCP-port] [-r] [-v] UDP-addr/UDP-port[/ttl]
           -s: Server mode.  Wait for TCP connections on the port.
           -c: Client mode.  Connect to the given address.
           -r: RTP mode.  Connect/listen on ports N and N+1 for both UDP and TCP.
               Port numbers must be even.
           -v: Verbose mode.  Specify -v multiple times for increased verbosity.
    EOS
  end
end
