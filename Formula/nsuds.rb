class Nsuds < Formula
  desc "Ncurses Sudoku system"
  homepage "https://nsuds.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/nsuds/nsuds/nsuds-0.7B/nsuds-0.7B.tar.gz"
  sha256 "6d9b3e53f3cf45e9aa29f742f6a3f7bc83a1290099a62d9b8ba421879076926e"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/nsuds[._-]v?(\d+(?:\.\d+)+[A-Z]?)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2ecaaf40921ec2ffab8d76a56b7ee28fd4529d1bdd7f8279658e1d2a1fb64261"
  end

  head do
    url "https://git.code.sf.net/p/nsuds/code.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  uses_from_macos "ncurses"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `showmarks'; nsuds-grid.o:(.bss+0x60): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    # Temporary Homebrew-specific work around for linker flag ordering problem in Ubuntu 16.04.
    # Remove after migration to 18.04.
    ENV["LDADD"] = "-lncurses -lm" unless OS.mac?
    system "autoreconf", "-i" if build.head?
    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    inreplace "src/Makefile", /chgrp .*/, ""
    system "make", "install"
  end

  test do
    assert_match(/nsuds version #{version}$/, shell_output("#{bin}/nsuds -v"))
  end
end
