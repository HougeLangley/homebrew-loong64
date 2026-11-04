class Pngcrush < Formula
  desc "Optimizer for PNG files"
  homepage "https://pmt.sourceforge.io/pngcrush/"
  url "https://downloads.sourceforge.net/project/pmt/pngcrush/1.8.13/pngcrush-1.8.13-nolib.tar.xz"
  sha256 "3b4eac8c5c69fe0894ad63534acedf6375b420f7038f7fc003346dd352618350"
  # The license is similar to "Zlib" license with clauses phrased like
  # the "Libpng" license section for libpng version 0.5 through 0.88.
  license :cannot_represent

  livecheck do
    url :stable
    regex(%r{url=.*?/pngcrush[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    rebuild 3
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c5768f38bb0b3f5403c7401e9e3949a465c01312c2fa5eff13edc357ec5fa983"
  end

  depends_on "libpng"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Use Debian's patch to fix build with `libpng`.
  patch do
    url "https://sources.debian.org/data/main/p/pngcrush/1.8.13-1/debian/patches/ignore_PNG_IGNORE_ADLER32.patch"
    sha256 "d1794d1ffef25a1c974caa219d7e33c0aa94f98c572170ec12285298d0216c29"
    type :unofficial
    resolves "https://sourceforge.net/p/pmt/bugs/82/"
  end

  def install
    zlib = OS.mac? ? "#{MacOS.sdk_path}/usr" : formula_opt_prefix("zlib-ng-compat")
    args = %W[
      CC=#{ENV.cc}
      LD=#{ENV.cc}
      CFLAGS=#{ENV.cflags}
      LDFLAGS=#{ENV.ldflags}
      PNGINC=#{formula_opt_include("libpng")}
      PNGLIB=#{formula_opt_lib("libpng")}
      ZINC=#{zlib}/include
      ZLIB=#{zlib}/lib
    ]
    system "make", *args
    bin.install "pngcrush"
  end

  test do
    system bin/"pngcrush", test_fixtures("test.png"), File::NULL
  end
end
