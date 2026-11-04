class Rtmidi < Formula
  desc "API for realtime MIDI input/output"
  homepage "https://github.com/thestk/rtmidi"
  url "https://github.com/thestk/rtmidi/archive/refs/tags/6.1.0.tar.gz"
  sha256 "809ce56bfa67b80afcfa566927ce242a60b6f4c1bacc7e89486fbcf5624c5721"
  license "MIT"
  compatibility_version 1
  head "https://github.com/thestk/rtmidi.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "539f438f7d1fff64765b1e9588a21f96f50ba21dad1d9d9c4df6c8a93711d81e"
  end



  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  on_linux do
    depends_on "alsa-lib"
    depends_on "jack"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DRTMIDI_BUILD_TESTING=OFF", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "RtMidi.h"
      #include <iostream>
      #include <vector>
      int main() {
        std::vector<RtMidi::Api> apis;
        RtMidi::getCompiledApi(apis);
        for (auto api : apis) std::cout << RtMidi::getApiName(api) << "\\n";
      }
    CPP
    system ENV.cxx, "test.cpp", "-o", "test", "-std=c++11", "-I#{include}/rtmidi", "-L#{lib}", "-lrtmidi"
    # Creating a MIDI client needs a reachable MIDIServer, which headless macOS 27 CI lacks (kMIDINoConnection)
    assert_match OS.mac? ? "core" : "alsa", shell_output("./test")
  end
end
