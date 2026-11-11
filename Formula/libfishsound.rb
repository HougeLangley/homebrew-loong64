class Libfishsound < Formula
  desc "Decode and encode audio data using the Xiph.org codecs"
  homepage "https://xiph.org/fishsound/"
  url "https://ftp.osuosl.org/pub/xiph/releases/libfishsound/libfishsound-1.0.1.tar.gz"
  mirror "https://mirror.csclub.uwaterloo.ca/xiph/releases/libfishsound/libfishsound-1.0.1.tar.gz"
  sha256 "03eb1601e2306adc88c776afdf212217c6547990d2d0f9ca544dad9a8a9dbb8f"
  license "BSD-3-Clause"

  livecheck do
    url "https://ftp.osuosl.org/pub/xiph/releases/libfishsound/?C=M&O=D"
    regex(%r{href=(?:["']?|.*?/)libfishsound[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "db2f3165047b8a9ed3fdf7fc59c2f99b5765e139569c46ec9d884e9b6d7fc74f"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "libvorbis"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stddef.h>
      #include <fishsound/fishsound.h>

      int main(void) {
        FishSoundInfo info;
        info.samplerate = 8000;
        info.channels = 1;
        info.format = FISH_SOUND_VORBIS;

        FishSound *fsound = fish_sound_new(FISH_SOUND_ENCODE, &info);
        if (fsound == NULL) return 1;
        fish_sound_delete(fsound);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs fishsound").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    system "./test"
  end
end
