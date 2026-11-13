class Csfml < Formula
  desc "SMFL bindings for C"
  homepage "https://www.sfml-dev.org/"
  url "https://github.com/SFML/CSFML/archive/refs/tags/3.0.0.tar.gz"
  sha256 "903cd4a782fb0b233f732dc5b37861b552998e93ae8f268c40bd4ce50b2e88ca"
  license "Zlib"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "022090362570bdd56694a0f11836cabbd393e82c30380683408c7183c4069268"
  end

  head "https://github.com/SFML/CSFML.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "sfml"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <CSFML/System/Clock.h>
      #include <CSFML/System/Sleep.h>

      int main(void)
      {
          sfClock* clock = sfClock_create();
          sfSleep(sfMilliseconds(10));
          sfTime elapsed = sfClock_getElapsedTime(clock);
          sfClock_destroy(clock);
          return elapsed.microseconds >= 10000 ? 0 : 1;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lcsfml-system", "-o", "test"
    system "./test"
  end
end
