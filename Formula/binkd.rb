class Binkd < Formula
  desc "TCP/IP FTN Mailer"
  homepage "https://github.com/pgul/binkd"
  url "https://github.com/pgul/binkd/archive/refs/tags/binkd-1_0_4.tar.gz"
  sha256 "67cc5c254198005e6d7c5c98b1d161ad146615874df4839daa86735aa5e3fa1d"
  license "GPL-2.0-or-later"
  head "https://github.com/pgul/binkd.git", branch: "master"

  livecheck do
    url :stable
    regex(/^(?:binkd[._-])?v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end

  bottle do
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "376f11cc4dd37b2841fde25a2c3cf6af3db6fc2ad48626e0a9950210a0562245"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "98ede139dd485567a090cc5cc53906f6307761c12fa3a045f1e0849e8ad99ca1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "0cebbe4af0138e31dc3dbcd9f345f58deecc65a35d5093f6ba3ac148bd3a938a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "092929f47b8414deb86f31cdad9b6b972b04e8c780780f94c331dc6b3a13c9a0"
    sha256 cellar: :any_skip_relocation, sonoma:            "ed2d0b7abdfd578a93e0c513dfba8eeab4a1b4f078e2c99a42946bc4a7985ec4"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "3823ed397a9c36d9a3bedaa37a8a6691c41902de71a82528d31c31fa7fe7bb1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "982860ec2548583dda4b84be1f8efdfc18b34bc4bbc9b665f3d98ce280a6720f"
  end

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    cp Dir["mkfls/unix/*"].select { |f| File.file? f }, "."
    inreplace "binkd.conf", "/var/", "#{var}/" if build.stable?
    system "./configure", "--disable-silent-rules",
                          "--mandir=#{man}",
                          *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    system sbin/"binkd", "-v"
  end
end
