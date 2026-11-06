class Dvdbackup < Formula
  desc "Rip DVD's from the command-line"
  homepage "https://dvdbackup.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/dvdbackup/dvdbackup/dvdbackup-0.4.2/dvdbackup-0.4.2.tar.gz"
  sha256 "0a37c31cc6f2d3c146ec57064bda8a06cf5f2ec90455366cb250506bab964550"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d2c08e962205539498dbccc25292ea85fd87ec6d3df18d33e40fa3f0e9c54dec"
  end

  revision 3


  depends_on "libdvdread"

  # Fix compatibility with libdvdread 6.1.0. See:
  patch do
    file "Patches/dvdbackup/compat.patch"
    type :unofficial
    resolves "https://bugs.launchpad.net/dvdbackup/+bug/1869226"
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

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--mandir=#{man}",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"dvdbackup", "--version"
  end
end
