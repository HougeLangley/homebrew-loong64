class Dvdbackup < Formula
  desc "Rip DVD's from the command-line"
  homepage "https://dvdbackup.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/dvdbackup/dvdbackup/dvdbackup-0.4.2/dvdbackup-0.4.2.tar.gz"
  sha256 "0a37c31cc6f2d3c146ec57064bda8a06cf5f2ec90455366cb250506bab964550"
  license "GPL-3.0-or-later"
  revision 3


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "90b15b6b6ce7bd26a24f41a3953584af56d16430f34fa4c40195f9865ad04f1c"
  end

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
      [cf, "buildaux/#{cf}", "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |rel|
        src = "/usr/share/libtool/build-aux/#{cf}"
        dest = buildpath/rel
        if dest.exist? && File.exist?(src)
          File.chmod(0644, dest)
          cp src, dest
        end
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
