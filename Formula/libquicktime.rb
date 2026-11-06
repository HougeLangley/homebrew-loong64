class Libquicktime < Formula
  desc "Library for reading and writing quicktime files"
  homepage "https://libquicktime.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/libquicktime/libquicktime/1.2.4/libquicktime-1.2.4.tar.gz"
  sha256 "1c53359c33b31347b4d7b00d3611463fe5e942cae3ec0fefe0d2fd413fd47368"
  license "LGPL-2.1-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "661f8be959c7b0d2b58aca98f11500c6af021bb258da34e62e42fe161cfeff2b"
  end

  revision 5


  depends_on "pkgconf" => :build

  on_macos do
    depends_on "gettext"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Fix CVE-2016-2399. Applied upstream on March 6th 2017.
  # Also, fixes from upstream for CVE-2017-9122 through CVE-2017-9128, applied
  # by Debian since 30 Jun 2017.
  patch do
    url "https://deb.debian.org/debian/pool/main/libq/libquicktime/libquicktime_1.2.4-12.debian.tar.xz"
    sha256 "e5b5fa3ec8391b92554d04528568d04ea9eb5145835e0c246eac7961c891a91a"
    type :backport
    resolves "CVE-2016-2399",
             "CVE-2017-9122", "CVE-2017-9123", "CVE-2017-9124", "CVE-2017-9125",
             "CVE-2017-9126", "CVE-2017-9127", "CVE-2017-9128"
    apply "patches/CVE-2016-2399.patch"
    apply "patches/CVE-2017-9122_et_al.patch"
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm64?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "--enable-gpl",
                          "--without-doxygen",
                          "--without-gtk",
                          "--without-x",
                          *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    fixture = test_fixtures("test.m4a")
    output = shell_output("#{bin}/qtinfo #{fixture} 2>&1")
    assert_match "length 1536 samples, compressor mp4a", output
    assert_path_exists testpath/".libquicktime_codecs"
  end
end
