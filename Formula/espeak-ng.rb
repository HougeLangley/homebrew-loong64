class EspeakNg < Formula
  desc "Speech synthesizer that supports more than hundred languages and accents"
  homepage "https://github.com/espeak-ng/espeak-ng"
  url "https://github.com/espeak-ng/espeak-ng/archive/refs/tags/1.52.0.tar.gz"
  sha256 "bb4338102ff3b49a81423da8a1a158b420124b055b60fa76cfb4b18677130a23"
  # NOTE: We omit BSD-2-Clause as getopt.c is only used on Windows
  license "GPL-3.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7a63151c9af5b1418a9c95326c147121f79bf24cc8e21149293316415f07d8cd"
  end

  head "https://github.com/espeak-ng/espeak-ng.git", branch: "master"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pcaudiolib"

  conflicts_with "espeak", because: "both install `espeak` binaries"

  deny_network_access!

  def install
    touch "NEWS"
    touch "AUTHORS"
    touch "ChangeLog"

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    # Real audio output fails on macOS CI runner, maybe due to permissions
    audio_output = if OS.mac? && ENV["HOMEBREW_GITHUB_ACTIONS"]
      "AUDIO_OUTPUT_RETRIEVAL"
    else
      "AUDIO_OUTPUT_PLAYBACK"
    end

    (testpath/"test.cpp").write <<~CPP
      #include <espeak/speak_lib.h>
      #include <iostream>
      #include <cstring>

      int main() {
        std::cout << "Initializing espeak-ng..." << std::endl;

        espeak_POSITION_TYPE position_type = POS_CHARACTER;
        espeak_AUDIO_OUTPUT output = #{audio_output};
        int options = 0;
        void* user_data = nullptr;
        unsigned int* unique_identifier = nullptr;

        espeak_Initialize(output, 500, nullptr, options);
        espeak_SetVoiceByName("en");

        const char *text = "Hello, Homebrew test successful!";
        size_t text_length = strlen(text) + 1;
        std::cout << "Synthesizing speech..." << std::endl;
        espeak_Synth(text, text_length, 0, position_type, 0, espeakCHARS_AUTO, unique_identifier, user_data);
        espeak_Synchronize();
        espeak_Terminate();

        std::cout << "espeak-ng terminated successfully." << std::endl;

        return 0;
      }
    CPP

    system ENV.cxx, "test.cpp", "-L#{lib}", "-lespeak-ng", "-o", "test"
    system "./test"
  end
end
