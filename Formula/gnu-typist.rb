class GnuTypist < Formula
  desc "GNU typing tutor"
  homepage "https://www.gnu.org/software/gtypist/"
  url "https://ftpmirror.gnu.org/gtypist/gtypist-2.10.1.tar.xz"
  mirror "https://ftp.gnu.org/gnu/gtypist/gtypist-2.10.1.tar.xz"
  sha256 "ca618054e91f1ed5ef043fcc43500bbad701c959c31844d4688ff22849ac252d"
  license "GPL-3.0-or-later"

  bottle do
    rebuild 1
    sha256 arm64_golden_gate: "75b31b05e985e30741568900b994d8cf0277dce309ec0c63a672fc29d8a2c213"
    sha256 arm64_tahoe:       "f47594d59df3c42dcaeee9f73264471981464416b412786124b0c4a7b3a70df1"
    sha256 arm64_sequoia:     "15ba375ec67355fe2043282cd1de4a229fd8d29b4857f73e22b05c8d702fe9e2"
    sha256 arm64_sonoma:      "df74aca9130820bcdbc021116652a23122835e14016003aac9ef0f0d8bdab972"
    sha256 arm64_ventura:     "790643311a056fa38bc014e51107bf0984f25d77506f86e60f3843ac8ee5b3cc"
    sha256 sonoma:            "7d10079dae92ce4490e710e6fb6ebe12c6d0703ae8d8a0f31b48c4759a8325d4"
    sha256 ventura:           "7cc31cf6f3f5cd325c69d8b61fe0a75e0f1fd0ab0be47649ca06423a14fed6cf"
    sha256 arm64_linux:       "879de43a7a494a24e1eb6f732b6dadb1a6c9af1de7911b2872a7322503f6e5dd"
    sha256 x86_64_linux:      "15b3985018e2cb520b709f0cf8c0b41307c49caf6756255638a1ddc9f37f3ac6"
  end

  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext"
  end

  # Use Apple's ncurses instead of ncursesw.
  # TODO: use an IFDEF for apple and submit upstream
  patch do
    file "Patches/gnu-typist/2.10.patch"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

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
    _cmflags = ["-DCMAKE_C_FLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "-DCMAKE_CXX_FLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"].freeze
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
    # libiconv is not linked properly without this
    ENV.append "LDFLAGS", "-liconv" if OS.mac?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-lispdir=#{elisp}", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    session = spawn bin/"gtypist", "-t", "-q", "-l", "DEMO_0", share/"gtypist/demo.typ"
    sleep 2
    Process.kill("TERM", session)
    Process.wait(session)
  end
end
