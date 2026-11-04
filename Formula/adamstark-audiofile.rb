class AdamstarkAudiofile < Formula
  desc "C++ Audio File Library by Adam Stark"
  homepage "https://github.com/adamstark/AudioFile"
  url "https://github.com/adamstark/AudioFile/archive/refs/tags/1.1.4.tar.gz"
  sha256 "e3749f90a9356b5206ef8928fa0a9c039e7db49e46bb7f32c3963d6c44c5bea8"
  license "MIT"
  head "https://github.com/adamstark/AudioFile.git", branch: "master"


  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "303a29daf658e948489ce77c4275722f5eb9ff135e0a4f0d086a6056c61d2f3a"
  end

  def install
    include.install "AudioFile.h"
  end

  test do
    (testpath/"audiofile.cc").write <<~CPP
      #include "AudioFile.h"
      int main(int argc, char* *argv) {
        AudioFile<double> audioFile;
        AudioFile<double>::AudioBuffer abuf;
        return 0;
      }
    CPP

    system ENV.cxx, "-std=c++17",
           "-I#{include}",
           "-o", "audiofile",
           "audiofile.cc"
    system "./audiofile"
  end
end
