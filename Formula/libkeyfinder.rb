class Libkeyfinder < Formula
  desc "Musical key detection for digital audio, GPL v3"
  homepage "https://mixxxdj.github.io/libkeyfinder/"
  url "https://github.com/mixxxdj/libkeyfinder/archive/refs/tags/2.2.8.tar.gz"
  sha256 "a54fc6c5ff435bb4b447f175bc97f9081fb5abf0edd5d125e6f5215c8fff4d11"
  license "GPL-3.0-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e0c6e1eef0e3a7776a48335e6f502dfd7ee69dd9fce7d57f3b32f826e0f223a1"
  end

  depends_on "cmake" => :build
  depends_on "fftw"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <keyfinder/keyfinder.h>
      #include <keyfinder/workspace.h>
      int main(void) {
        KeyFinder::Workspace w;
        w.chromagram = new KeyFinder::Chromagram(1);
        KeyFinder::KeyFinder kf;
        return KeyFinder::SILENCE == kf.keyOfChromagram(w) ? 0 : 1;
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++11", "-I#{include}", "-L#{lib}", "-lkeyfinder", "-o", "test"
    system "./test"
  end
end
