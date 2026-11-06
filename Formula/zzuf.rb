class Zzuf < Formula
  desc "Transparent application input fuzzer"
  homepage "http://caca.zoy.org/wiki/zzuf"
  url "https://github.com/samhocevar/zzuf/releases/download/v0.15/zzuf-0.15.tar.bz2"
  sha256 "04353d94c68391b3945199f100ab47fc5ff7815db1e92581a600d4175e3a6872"
  license "WTFPL"

  bottle do
    sha256                               arm64_golden_gate: "301f0b8d8c0d552c91914fb8401ff8d7eec9ca134e16c3990b1ab98d21de240a"
    sha256                               arm64_tahoe:       "a4c4c66658aa63cc815d056e06bce100d7907cfd53179b98b596f440a1d0cd15"
    sha256                               arm64_sequoia:     "6ccb5e6621aa95f4cb62afebe5f4c3aee322b8d207a10d3cbdc16bb073c09aa5"
    sha256                               arm64_sonoma:      "6fce95c82da3ed7282dfbc55f4b276910b78fa5d76b2d5e66ad9b43607828fcf"
    sha256                               arm64_ventura:     "16fc98439ca072e8cf19c129649eff99e63e0cece1c1455e97f04ce7cb4dfd73"
    sha256                               arm64_monterey:    "8cf189e969a94737e6729be772df9f64759b7c33580cee51d571b31365dbddf2"
    sha256                               arm64_big_sur:     "7ff801dd276cdd8f830d07d01c97a83207ed8ac77c6023ff21b29a2ec536637b"
    sha256                               sonoma:            "e6a2bcac4710033bd155592753c6d4446a3771c70a9cdaa86f34a33f968db122"
    sha256                               ventura:           "397eb044876f87b27787679b9a8f965da0aca9251386aa2a6dbbd1b5ef8cd3c9"
    sha256                               monterey:          "2cfa284477cd1e81ac3b248a20f25812083fe7b592a997ecbefee7663cedab91"
    sha256                               big_sur:           "284b235c4c744d7be86fbe6175a8d67a743a429c8021437182a31e6184105437"
    sha256                               arm64_linux:       "c7c8ec8267f9b314e98b81cd5bb9a9765b51d1bce2f4dfd00798ac823affd99e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "7164c38ad977edfad3d137b9071e22f185effde9165996e847facd20f4df0e65"
  end

  head do
    url "https://github.com/samhocevar/zzuf.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "pkgconf" => :build
  end

  deny_network_access!

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
    system "./bootstrap" if build.head?

    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403
    ENV.append_to_cflags "-Wno-int-conversion" if DevelopmentTools.clang_build_version >= 1500

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    output = pipe_output("#{bin}/zzuf -i -B 4194304 -r 0.271828 -s 314159 -m < /dev/zero").chomp
    assert_equal "zzuf[s=314159,r=0.271828]: 549e1200590e9c013e907039fe535f41", output
  end
end
