class Portmidi < Formula
  desc "Cross-platform library for real-time MIDI I/O"
  homepage "https://github.com/PortMidi/portmidi"
  url "https://github.com/PortMidi/portmidi/archive/refs/tags/v2.0.8.tar.gz"
  sha256 "f21201d4cc233638d7bb6ee29ee6dece54f6c9c1aeb7989bc978001caaf2f666"
  license "MIT"
  version_scheme 1
  compatibility_version 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "75914ed4ddd8f526d5268fa47c19fc17aa9b962c5bb1696f31526c11d9329810"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "alsa-lib"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <portmidi.h>

      int main()
      {
        int count = -1;
        count = Pm_CountDevices();
        if(count >= 0)
            return 0;
        else
            return 1;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lportmidi", "-o", "test"
    system "./test"
  end
end
