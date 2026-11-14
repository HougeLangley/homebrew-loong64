class Flac < Formula
  desc "Free lossless audio codec"
  homepage "https://xiph.org/flac/"
  url "https://ftp.osuosl.org/pub/xiph/releases/flac/flac-1.5.0.tar.xz"
  mirror "https://github.com/xiph/flac/releases/download/1.5.0/flac-1.5.0.tar.xz"
  sha256 "f2c1c76592a82ffff8413ba3c4a1299b6c7ab06c734dee03fd88630485c2b920"
  license all_of: [
    "BSD-3-Clause",
    "GPL-2.0-or-later",
    "ISC",
    "LGPL-2.0-or-later",
    "LGPL-2.1-or-later",
    :public_domain,
    any_of: ["GPL-2.0-or-later", "LGPL-2.1-or-later"],
  ]

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/flac/?C=M&O=D"
    regex(%r{href=(?:["']?|.*?/)flac[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "51e7113acde9e30bade2ac2d7822c856d68db39af912568dd72ce5613d8edf08"
  end

  head do
    url "https://gitlab.xiph.org/xiph/flac.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libogg"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
      end
    end

    system "./autogen.sh" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-static", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"flac", "--decode", "--force-raw", "--endian=little", "--sign=signed",
                       "--output-name=out.raw", test_fixtures("test.flac")
    system bin/"flac", "--endian=little", "--sign=signed", "--channels=1", "--bps=8",
                       "--sample-rate=8000", "--output-name=out.flac", "out.raw"
  end
end
