class Libnfc < Formula
  desc "Low level NFC SDK and Programmers API"
  homepage "https://github.com/nfc-tools/libnfc"
  url "https://github.com/nfc-tools/libnfc/releases/download/libnfc-1.8.0/libnfc-1.8.0.tar.bz2"
  sha256 "6d9ad31c86408711f0a60f05b1933101c7497683c2e0d8917d1611a3feba3dd5"
  license "LGPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "03edca406c60bcaca73caffc3c072fa06e48c03c8fd5800eba7983f546031a29"
  end

  compatibility_version 1


  head do
    url "https://github.com/nfc-tools/libnfc.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkgconf" => :build
  depends_on "libusb-compat"

  uses_from_macos "pcsc-lite"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--enable-serial-autoprobe",
                          "--with-drivers=all",
                          *std_configure_args
    system "make", "install"
    (prefix/"etc/nfc/libnfc.conf").write "allow_intrusive_scan=yes"
  end

  test do
    system bin/"nfc-list"
  end
end
