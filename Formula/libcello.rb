class Libcello < Formula
  desc "Higher-level programming in C"
  homepage "https://libcello.org/"
  url "https://libcello.org/static/libCello-2.1.0.tar.gz"
  sha256 "49acf6525ac6808c49f2125ecdc101626801cffe87da16736afb80684b172b28"
  license "BSD-2-Clause"
  head "https://github.com/orangeduck/Cello.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?libCello[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b07c1166b1925e630dbf01fdcaa2a6948e6acaeee4e05908e77000836f33e996"
  end

  def install
    system "make", "check"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~C
      #include "Cello.h"

      int main(int argc, char** argv) {
        var i0 = $(Int, 5);
        var i1 = $(Int, 3);
        var items = new(Array, Int, i0, i1);
        foreach (item in items) {
          print("Object %$ is of type %$\\n", item, type_of(item));
        }
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lCello", "-lpthread", "-o", "test"
    system "./test"
  end
end
