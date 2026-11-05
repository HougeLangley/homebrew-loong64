class Truecrack < Formula
  desc "Brute-force password cracker for TrueCrypt"
  homepage "https://github.com/lvaccaro/truecrack"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/truecrack/truecrack_v35.tar.gz"
  version "3.5"
  sha256 "25bf270fa3bc3591c3d795e5a4b0842f6581f76c0b5d17c0aef260246fe726b3"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a0132289153c0430def28106d2b95d69f5910a1e589fb6d1fcae0f0eb027ca28"
  end


  # Fix missing return value compilation issue
  patch do
    url "https://gist.githubusercontent.com/anonymous/b912a1ede06eb1e8eb38/raw/1394a8a6bedb7caae8ee034f512f76a99fe55976/truecrack-return-value-fix.patch"
    sha256 "8aa608054f9b822a1fb7294a5087410f347ba632bbd4b46002aada76c289ed77"
    type :unofficial
    resolves "https://github.com/lvaccaro/truecrack/issues/41"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    if OS.linux?
      # Issue ref: https://github.com/lvaccaro/truecrack/issues/56
      inreplace "src/Makefile.in", /^CFLAGS = /, "\\0-fcommon -Wno-implicit-function-declaration "
    elsif DevelopmentTools.clang_build_version >= 1403
      # Fix compile with newer Clang
      inreplace "src/Makefile.in", /^CFLAGS = /, "\\0-Wno-implicit-function-declaration "
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    # Re datarootdir override: Dumps two files in top-level share
    # (autogen.sh and cudalt.py) which could cause conflict elsewhere.
    system "./configure", "--enable-cpu",
                          "--datarootdir=#{pkgshare}",
                          "--mandir=#{man}",
                          *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"truecrack"
  end
end
