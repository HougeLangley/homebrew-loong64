class Chordii < Formula
  desc "Text file to music sheet converter"
  homepage "https://www.vromans.org/johan/projects/Chordii/"
  url "https://downloads.sourceforge.net/project/chordii/chordii/4.5/chordii-4.5.3b.tar.gz"
  sha256 "edb19be9de456366e592a75a5ce1c0a75352a55d5b4e5f282c953c7e7f2d87b5"
  license "GPL-3.0-or-later"

  livecheck do
    url "https://sourceforge.net/projects/chordii/rss?path=/chordii"
    regex(%r{url=.*?/chordii[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "7ef93583c8a8014ec9318e19ae10d319c149e11f10fa2cabbcd996d25389295d"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "d07735a1513b3c86ea5fa4db756e4c2238c7bb4ab60bfda160e56940c5abca28"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d957516291bf50268bfc7a90bfb72ae62ae3e54e249a6156033f0938c9d4fbbf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:      "d68e6d5490b3ee5a4f07fc445faa9716fd72ce3fbf89285d9eceb2cfa2696dcf"
    sha256 cellar: :any_skip_relocation, arm64_ventura:     "6a978e9a6f9374a3129e063dbc1c530c3d783a59ace97773a42c25e9046d0608"
    sha256 cellar: :any_skip_relocation, arm64_monterey:    "a3296c96f2502beef0d8730a8fe434f997b831737cfa352d8882b59303becc16"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:     "048b6fde3228875e2f6e9267c71eb6228b3b0382ce638f9b2e29199ec3cf7aa2"
    sha256 cellar: :any_skip_relocation, sonoma:            "108b4600c4d39a1ebffbe13cb9a0841a53cfff76de078409b8a213386611219e"
    sha256 cellar: :any_skip_relocation, ventura:           "533776ba55d08f2e8f35a1efe53ba52e97e1d360029f97dfb10dedc5c7920857"
    sha256 cellar: :any_skip_relocation, monterey:          "2b6187af85a480a5e77c8b39a539b6ecd2e2be2f66314088a97a83024f8bb584"
    sha256 cellar: :any_skip_relocation, big_sur:           "d7c6ea34e2f65484ebc2d74c2f658f09ef78e2893bb6ee7f7674f1c72f8d8f98"
    sha256 cellar: :any_skip_relocation, arm64_linux:       "03f604ff4981449be5916104ec86dc67e1c1df565f0f064b9689149f82b9b58d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:      "8dc33f2a8fd3dda76dc87a7a919c7e590a4853a0736bc92c20d25e0d8382db6d"
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
    # Work around failure from GCC 10+ using default of `-fno-common`
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "CFLAGS=-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types", "CXXFLAGS=-std=gnu++17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int -Wno-error=implicit-function-declaration -Wno-error=int-conversion -Wno-error=incompatible-pointer-types",  "CC=/home/houge/infra/ci/bin/cc-compat",  "CC2=/home/houge/infra/ci/bin/cc-compat",  "CXX=/home/houge/infra/ci/bin/cxx-compat", "install"
  end

  test do
    (testpath/"homebrew.cho").write <<~EOS
      {title:Homebrew}
      {subtitle:I can't write lyrics. Send help}

      [C]Thank [G]You [F]Everyone,
      [C]We couldn't maintain [F]Homebrew without you,
      [G]Here's an appreciative song from us to [C]you.
    EOS

    system bin/"chordii", "--output=#{testpath}/homebrew.ps", "homebrew.cho"
    assert_path_exists testpath/"homebrew.ps"
  end
end
