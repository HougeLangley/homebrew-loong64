class Fq < Formula
  desc "Brokered message queue optimized for performance"
  homepage "https://github.com/circonus-labs/fq"
  url "https://github.com/circonus-labs/fq/archive/refs/tags/v0.13.12.tar.gz"
  sha256 "4329fa7678437c2d22f021ec8a5bed2b7a7eeb608bbfe4c8749f8520011b12d3"
  license "MIT"
  head "https://github.com/circonus-labs/fq.git", branch: "master"

  bottle do
    rebuild 1
    sha256 arm64_golden_gate: "0ee4f40eee6d68ea8e39759b2bdb59036eb03863b435c0ca11d21243e2b3a26c"
    sha256 arm64_tahoe:       "af9f15d2ab89561c12e797f7e709e1b26e47cce0759823f5c6d0478a003b6198"
    sha256 arm64_sequoia:     "9bb54081fd33ccff3f7cbef0361a7cd1744ba09cbb67f41e779a1dda1b4cd251"
    sha256 arm64_linux:       "0d08e1ca55ac0b75b522c204cb0aca4bd0044e1f287088858bb84a6cfe9d04a9"
    sha256 x86_64_linux:      "2c21025a440f8167559fb2daf944f4fbc138b23a472aa0b4f792bc69e0bff46b"
  end

  depends_on "concurrencykit"
  depends_on "jlog"

  uses_from_macos "sqlite"

  on_linux do
    depends_on "bind" => :test # for `dig`
    depends_on "openssl@4"
    depends_on "util-linux"
  end

  def install
    _ck_inc = Formula["concurrencykit"].opt_include
    _jlog_inc = Formula["jlog"].opt_include
    _jlog_lib = Formula["jlog"].opt_lib
    _ck_lib = Formula["concurrencykit"].opt_lib
    _flags = "-DNO_BCD=1 -D_REENTRANT -DLIBEXECDIR=\\\"#{libexec}\\\" -DSYSCONFDIR=\\\"#{etc}\\\" -DLOCALSTATEDIR=\\\"#{var}\\\" -I#{_ck_inc} -I#{_jlog_inc} -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    # concurrencykit is keg-only: headers live in its opt prefix, and fq's
    # hand-written Makefile does not query pkg-config for it.
    ck = Formula["concurrencykit"]
    ENV.append "CPPFLAGS", "-I#{ck.opt_include}"
    ENV.append "CFLAGS", "-I#{ck.opt_include}"
    ENV.append "LDFLAGS", "-L#{ck.opt_lib}"
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
      _m = _m.sub(/^(CFLAGS[ \t]*[+:]?=)/) { $1 + " -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration" }
      File.write(mkf, _m)
    end
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration"
    ENV.append_to_cflags "-DNO_BCD=1"
    inreplace "Makefile", "-lbcd", ""
    inreplace "Makefile", "/usr/lib/dtrace", "#{lib}/dtrace"
    system "make", "CFLAGS=#{_flags}", "CXXFLAGS=#{_flags}", "LDFLAGS=-L#{_ck_lib} -L#{_jlog_lib}",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "PREFIX=#{prefix}"
    args = ["PREFIX=#{prefix}"]
    args << "ENABLE_DTRACE=0" unless OS.mac?
    system "make", "CFLAGS=#{_flags}", "CXXFLAGS=#{_flags}", "LDFLAGS=-L#{_ck_lib} -L#{_jlog_lib}",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install", *args
    bin.install "fqc", "fq_sndr", "fq_rcvr"
  end

  test do
    ipv4 = shell_output("dig -4 TXT +short o-o.myaddr.l.google.com @ns1.google.com | tr -d '\"'").strip
    port = free_port
    pid = spawn sbin/"fqd", "-p", port.to_s, "-n", ipv4, "-D", "-c", testpath/"test.sqlite"
    begin
      output = shell_output("curl --silent --retry 5 --retry-connrefused 127.0.0.1:#{port}")
      assert_match "Circonus Fq Operational Dashboard", output
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
