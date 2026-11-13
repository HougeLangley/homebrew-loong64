class Dvdrtools < Formula
  desc "Fork of cdrtools DVD writer support"
  homepage "https://savannah.nongnu.org/projects/dvdrtools/"
  url "https://download.savannah.gnu.org/releases/dvdrtools/dvdrtools-0.2.1.tar.gz"
  sha256 "053d0f277f69b183f9c8e8c8b09b94d5bb4a1de6d9b122c0e6c00cc6593dfb46"
  license "GPL-2.0-or-later"


  # Unmaintained fork of cdrtools that requires patches to build
  # Last release on 2005-02-05. cdrtools added support for DVD in 2006.
  deprecate! date: "2026-06-30", because: :unmaintained
  disable! date: "2027-06-30", because: :unmaintained

  conflicts_with "cdrtools", because: "both cdrtools and dvdrtools install binaries by the same name"

  # Below three patches via MacPorts.
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "120b30e7775ee75b7c92fbd53ea5c5b89e649e9e0e225bc919c2d29c97ed0735"
  end

  patch :p0 do
    file "Patches/dvdrtools/patch-cdda2wav-cdda2wav.c"
    type :unofficial
  end

  patch :p0 do
    file "Patches/dvdrtools/patch-cdrecord-cdrecord.c"
    type :unofficial
  end

  patch :p0 do
    file "Patches/dvdrtools/patch-scsi-mac-iokit.c"
    type :unofficial
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Fix compile with newer Clang
    if DevelopmentTools.clang_build_version >= 1403
      ENV.append_to_cflags "-Wno-implicit-function-declaration -Wno-int-conversion"
    end
    # 2005-era code relies on implicit declarations and K&R prototypes.
    ENV.append_to_cflags "-std=gnu17 -Wno-error=implicit-int -Wno-error=implicit-function-declaration"

    ENV["LIBS"] = "-framework IOKit -framework CoreFoundation" if OS.mac?

    args = ["--mandir=#{man}"]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dvdrecord -version").scrub
  end
end
