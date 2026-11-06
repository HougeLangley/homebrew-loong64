class GnuGo < Formula
  desc "Plays the game of Go"
  homepage "https://www.gnu.org/software/gnugo/gnugo.html"
  url "https://ftpmirror.gnu.org/gnugo/gnugo-3.8.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gnugo/gnugo-3.8.tar.gz"
  sha256 "da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72"
  # The `:cannot_represent` is for src/gtp.* which is similar to ICU license if
  # SPDX allowed replacing `this software ... (the "Software")` with `file gtp.c`
  license all_of: ["GPL-3.0-or-later", :public_domain, :cannot_represent]
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d4d3ada0ffeea0349ea027715d6d93cc5c35f216e4cf2c1f274796758a1f4b23"
  end

  revision 1
  head "https://git.savannah.gnu.org/git/gnugo.git", branch: "master"


  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `DRAW'; globals.o:(.bss+0x0): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--with-readline", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match(/GNU Go #{version}$/, shell_output("#{bin}/gnugo --version"))
  end
end
