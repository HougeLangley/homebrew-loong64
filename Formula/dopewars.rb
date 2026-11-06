class Dopewars < Formula
  desc 'Free rewrite of a game originally based on "Drug Wars"'
  homepage "https://dopewars.sourceforge.io"
  url "https://downloads.sourceforge.net/project/dopewars/dopewars/1.6.2/dopewars-1.6.2.tar.gz"
  sha256 "623b9d1d4d576f8b1155150975308861c4ec23a78f9cc2b24913b022764eaae1"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "56c69e05317b3e4f14b6a17bd66083ec629191a2624626760ee2c14c012f64dc"
  end


  depends_on "pkgconf" => :build

  depends_on "glib"

  uses_from_macos "curl"
  uses_from_macos "ncurses"

  on_macos do
    depends_on "gettext"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    inreplace "src/Makefile.in", "$(dopewars_DEPENDENCIES)", ""
    inreplace "src/Makefile.in", "chmod", "true"
    inreplace "auxbuild/ltmain.sh", "need_relink=yes", "need_relink=no"
    inreplace "src/plugins/Makefile.in", "LIBADD =", "LIBADD = -module -avoid-version"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-gui-client",
                          "--disable-gui-server",
                          "--enable-plugins",
                          "--enable-networking",
                          "--mandir=#{man}",
                          *std_configure_args
    system "make", "install", "chgrp=true"
  end

  test do
    system bin/"dopewars", "-v"
  end
end
