class Termbox < Formula
  desc "Library for writing text-based user interfaces"
  homepage "https://github.com/termbox/termbox"
  url "https://github.com/termbox/termbox/archive/refs/tags/v1.1.4.tar.gz"
  sha256 "402fa1b353882d18e8ddd48f9f37346bbb6f5277993d3b36f1fc7a8d6097ee8a"
  license "MIT"
  head "https://github.com/termbox/termbox.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d004d9070ff01ba32379a0578f42e95179cd86eeb09f7a4fb69bcf568da6e3c3"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <termbox.h>
      int main() {
        // we can't test other functions because the CI test runs in a
        // non-interactive shell
        tb_set_clear_attributes(42, 42);
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-ltermbox", "-o", "test"
    system "./test"
  end
end
