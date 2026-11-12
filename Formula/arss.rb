class Arss < Formula
  desc "Analyze a sound file into a spectrogram"
  homepage "https://arss.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/arss/arss/0.2.3/arss-0.2.3-src.tar.gz"
  sha256 "e2faca8b8a3902226353c4053cd9ab71595eec6ead657b5b44c14b4bef52b2b2"
  license "GPL-2.0-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "57ddb3985879859b2cf1f0f8f48c8921b8f036e0bc3440a824feae076880b46a"
  end

  depends_on "cmake" => :build
  depends_on "fftw"

  deny_network_access!

  def install
    # CMake Error in CMakeLists.txt: No cmake_minimum_required command is present.
    inreplace "src/CMakeLists.txt", /\A/, "cmake_minimum_required(VERSION 3.10)\n"

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `LOGBASE'; CMakeFiles/arss.dir/arss.o:(.bss+0x18): first defined here
    # multiple definition of `pi'; CMakeFiles/arss.dir/arss.o:(.bss+0x20): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    system "cmake", "-S", "src", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/arss"
  end

  test do
    system bin/"arss", "--version"
  end
end
