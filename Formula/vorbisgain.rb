class Vorbisgain < Formula
  desc "Add Replay Gain volume tags to Ogg Vorbis files"
  homepage "https://sjeng.org/vorbisgain.html"
  url "https://sjeng.org/ftp/vorbis/vorbisgain-0.37.tar.gz"
  sha256 "dd6db051cad972bcac25d47b4a9e40e217bb548a1f16328eddbb4e66613530ec"
  license "LGPL-2.1-only"

  livecheck do
    url "https://sjeng.org/ftp/vorbis/"
    regex(/href=.*?vorbisgain[._-]v?(\d+(?:\.\d+)+)\.(?:t|zip)/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "df0714ffe5a2af43ee0e56e69f0b39738422577a3755148e3330bf9e83b5200b"
  end

  depends_on "libogg"
  depends_on "libvorbis"

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # fix implicit-function-declaration errors
    ENV.append_to_cflags "-DGWINSZ_IN_SYS_IOCTL"
    inreplace "misc.c", "#include <string.h>", "#include <string.h>\n#include <unistd.h>"

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system bin/"vorbisgain", "--version"
  end
end
