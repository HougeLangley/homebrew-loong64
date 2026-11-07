class Gputils < Formula
  desc "GNU PIC Utilities"
  homepage "https://gputils.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/gputils/gputils/1.5.0/gputils-1.5.2.tar.bz2"
  sha256 "8fb8820b31d7c1f7c776141ccb3c4f06f40af915da6374128d752d1eee3addf2"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/gputils[._-]v?(\d+(?:\.\d+)+(?:-\d+)?)\.t}i)
  end

  bottle do
    sha256 arm64_golden_gate: "2a29061acf47406908316b3332d87981040d4c733d9824058b0e7640bfbb0110"
    sha256 arm64_tahoe:       "2320be53fb17f6a272346de555bd3aa73422f990493a92c24e693346e334f5e8"
    sha256 arm64_sequoia:     "002f4b80984f18e0c836c7672e342110f8a1fa7f8d45572acf70610361047d61"
    sha256 arm64_sonoma:      "c09d1d95618d889cd0dc37285588a1925872389388f636c70764b8e6d8b9eb35"
    sha256 arm64_ventura:     "973d66004e773aa92968ddcfd79781b1eead7689771fe5c0629241a77b625e26"
    sha256 arm64_monterey:    "ef9e856e54329ca707dbcda0c51cd85f2351a73de705f614f5936cc71baee4ad"
    sha256 arm64_big_sur:     "7c7d6f710f0b5d41014b34fc022e88007a508a185b4c12cc0c51ea3d26be58dc"
    sha256 sonoma:            "b45ab055abbfd7004c6ea59354b0e845944b2d140fc44aaa845482f49dfae0ce"
    sha256 ventura:           "dee33ce7d2ec0e90877801f33554fc3bb824c7ce2c3128ea3037af276c61eeb6"
    sha256 monterey:          "0033e9463df7f37295cf89c23335763769a2df27bcfd61121121467028922054"
    sha256 big_sur:           "7c3aefbcf78392080e05773e9e9ef9c289f15bd9e02b9e7f33ecae7cc2ccf3df"
    sha256 arm64_linux:       "0178958e579afb1c56b89d025d007eea69af1b68fc6bd7e7e4d8cb550e344212"
    sha256 x86_64_linux:      "980a09d45f616f560b368078822553d130d7630b813d92696fd15f894593bf4b"
  end

  def install
    # --- 追加缺失库 ---
    ENV.append "LIBS", "-lfl"
    ENV.append "LDFLAGS", "-lfl"
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
    system "./configure", "LIBS=-lfl", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "LIBS=-lfl", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    # assemble with gpasm
    (testpath/"test.asm").write " movlw 0x42\n end\n"
    system bin/"gpasm", "-p", "p16f84", "test.asm"
    assert_path_exists testpath/"test.hex"

    # disassemble with gpdasm
    output = shell_output("#{bin}/gpdasm -p p16f84 test.hex")
    assert_match "0000:  3042  movlw   0x42\n", output
  end
end
