class Pcaudiolib < Formula
  desc "Portable C Audio Library"
  homepage "https://github.com/espeak-ng/pcaudiolib"
  url "https://github.com/espeak-ng/pcaudiolib/releases/download/1.3/pcaudiolib-1.3.tar.gz"
  sha256 "e8bd15f460ea171ccd0769ea432e188532a7fb27fa73ec2d526088a082abaaad"
  license "GPL-3.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "155c44f38263da6849bf10e1b2043c170af1e4c230e427b6d436d4776e05ba05"
  end

  head do
    url "https://github.com/espeak-ng/pcaudiolib.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end


  depends_on "pkgconf" => :build

  on_linux do
    depends_on "alsa-lib"
    depends_on "pulseaudio"
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <pcaudiolib/audio.h>

      int main() {
        struct audio_object *my_audio = create_audio_device_object(NULL, "test", "test");
        int error = audio_object_open(my_audio, AUDIO_OBJECT_FORMAT_S16LE, 22050, 1);
        if (error != 0)
          printf("audio_object_open error: %s", audio_object_strerror(my_audio, error));
        audio_object_close(my_audio);
        audio_object_destroy(my_audio);
        return error;
      }
    C

    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-lpcaudio"
    if OS.mac?
      assert_match "Runtime error fffff448", shell_output("./test", 72) # error from sandbox
    else
      system "./test"
    end
  end
end
