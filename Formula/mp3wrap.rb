class Mp3wrap < Formula
  desc "Wrap two or more mp3 files in a single large file"
  homepage "https://mp3wrap.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mp3wrap/mp3wrap/mp3wrap%200.5/mp3wrap-0.5-src.tar.gz"
  sha256 "1b4644f6b7099dcab88b08521d59d6f730fa211b5faf1f88bd03bf61fedc04e7"
  license "LGPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/mp3wrap[._-]v?(\d+(?:\.\d+)+)(?:-src)?\.t}i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f4dd154085337ac800077f2a87be01e487528973e8ba4948465b055ca0591f59"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "28af69383fd4f657495f0aedda9e53ac66cccce24bda0a280ebf5a79939cce6e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "881da7c1c1c1d3b667f6524d66c01de8d73e8a113b84763ea0d57395518c3523"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "b5c9848d068d5f4f3758dc2629daea1ac755ce288b9663b302b13045bc9a1e0e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "e2bf343f21cede8d098ddb1c389818e91d8aaa8363601b1c3f56d02b2152285f"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "5a84d1acbd3aaa6432bf22d6052c1d8afa5b54145e1ecec0a16c6da05cf2df95"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "9ee84cc1015ba99900a71896d7055b3fcf305828dc6a8430da552b0fee18a01b"
    sha256 cellar: :any_skip_relocation, sonoma:            "73592a53432ef216313142884f12af2b40c2a62b86d4ed1539b3824d7c66f675"
    sha256 cellar: :any_skip_relocation, ventura:           "6f72f17884f6f657f8c8db28383b880d6fb4448181689997c9834d860d28b7bf"
    sha256 cellar: :any_skip_relocation, monterey:          "e07fa1bc62342d8166accae07efd264b0449ee57ed27224f05897444bbec43fc"
    sha256 cellar: :any_skip_relocation, big_sur:           "fb2198208b5da896231a815235652c3342ed305a858950c9fb10bc7e296d1e34"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "962b508b014f584bcb0ea88a84e150e6c0ebdb80573252a7ffca2c6bc25bb567"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "e666ba56f6a93702e3a37b4dd6f8d908b6a16246ba9ad5467518c970f4ac30ab"
  end

  deprecate! date: "2026-07-17", because: :unmaintained
  disable! date: "2027-01-17", because: :unmaintained

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
    # CFLAGS 里面追加（configure 硬编码时 ENV 追加不生效）
    if File.exist?("configure")
      _cfg = File.read("configure")
      _cfg = _cfg.gsub(/^CFLAGS="([^"]*)"/) { 'CFLAGS="' + $1 + ' -std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types' }
      File.write("configure", _cfg)
    end
    ENV.append_to_cflags "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types"
    # Workaround for arm64 linux. Upstream isn't actively maintained
    ENV.append_to_cflags "-fsigned-char" if OS.linux? && Hardware::CPU.arm?

    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    source = test_fixtures("test.mp3")
    system bin/"mp3wrap", testpath/"t.mp3", source, source
    assert_path_exists testpath/"t_MP3WRAP.mp3"
  end
end
