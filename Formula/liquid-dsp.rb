class LiquidDsp < Formula
  desc "Digital signal processing library for software-defined radios"
  homepage "https://liquidsdr.org/"
  url "https://github.com/jgaeddert/liquid-dsp/archive/refs/tags/v1.8.3.tar.gz"
  sha256 "18fa83b73db8bb6fe6ea0376e4b5aecf8645970f4604d10d9dadbf609f3f95e2"
  license "MIT"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "630e78c97ef4f833104044582c41d944d5a022eb316c53e1d56dc996a13e06a7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "fftw"

  def install
    system "./bootstrap.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <liquid/liquid.h>
      int main() {
        if (!liquid_is_prime(3))
          return 1;
        return 0;
      }
    C
    system ENV.cc, "test.c", "-o", "test", "-L#{lib}", "-lliquid"
    system "./test"
  end
end
