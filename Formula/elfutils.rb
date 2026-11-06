class Elfutils < Formula
  desc "Libraries and utilities for handling ELF objects"
  homepage "https://fedorahosted.org/elfutils/"
  url "https://sourceware.org/elfutils/ftp/0.197/elfutils-0.197.tar.bz2"
  sha256 "1fdf525f22dcf796d99a99ba3ea00a1f7b1ae5421bc62e8443a708920b99b904"
  license all_of: [
    "GPL-3.0-or-later", # programs
    { any_of: ["GPL-2.0-or-later", "LGPL-3.0-or-later"] }, # libraries
    "GFDL-1.3-no-invariants-or-later", # eu-readelf.1
  ]
  compatibility_version 1

  livecheck do
    url "https://sourceware.org/elfutils/ftp/"
    regex(%r{href=(?:["']?v?(\d+(?:\.\d+)+)/?["' >]|.*?elfutils[._-]v?(\d+(?:\.\d+)+)\.t)}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0144d385741b94130e8732fc16ccbf83aa00743c530976fa6c250cd8ddb1700b"
  end

  depends_on "m4" => :build
  depends_on "pkgconf" => :build
  depends_on "bzip2"
  depends_on :linux
  depends_on "xz"
  depends_on "zlib-ng-compat"
  depends_on "zstd"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = %w[
      --disable-silent-rules
      --disable-libdebuginfod
      --disable-debuginfod
      --with-bzlib
      --with-lzma
      --with-zlib
      --with-zstd
    ]
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *args, *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "elf_kind", shell_output("#{bin}/eu-nm #{bin}/eu-nm")
  end
end
