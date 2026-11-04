class Libreplaygain < Formula
  desc "Library to implement ReplayGain standard for audio"
  homepage "https://www.musepack.net/"
  url "https://files.musepack.net/source/libreplaygain_r475.tar.gz"
  version "r475"
  sha256 "8258bf785547ac2cda43bb195e07522f0a3682f55abe97753c974609ec232482"
  license "LGPL-2.1-or-later"
  compatibility_version 1

  livecheck do
    url "https://www.musepack.net/index.php?pg=src"
    regex(/href=.*?libreplaygain[._-](r\d+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e789d423d81d941e755e26afe0b5a69494df5b1aa112c1a9e7f6e8249652e53a"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # Fix build with CMake 4.0+.
    inreplace "CMakeLists.txt",
              "CMAKE_MINIMUM_REQUIRED(VERSION 2.4)",
              "CMAKE_MINIMUM_REQUIRED(VERSION 3.10)"

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    include.install "include/replaygain/"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <replaygain/gain_analysis.h>

      int main(void) {
        if (gain_init_analysis(44100) != INIT_GAIN_ANALYSIS_OK) return 1;
        if (gain_init_analysis(12345) != INIT_GAIN_ANALYSIS_ERROR) return 1;
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lreplaygain", "-lm", "-o", "test"
    system "./test"
  end
end
