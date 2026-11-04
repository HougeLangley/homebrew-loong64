class Fplll < Formula
  desc "Lattice algorithms using floating-point arithmetic"
  homepage "https://github.com/fplll/fplll"
  url "https://github.com/fplll/fplll/releases/download/5.5.0/fplll-5.5.0.tar.gz"
  sha256 "f0af6bdd0ebd5871e87ff3ef7737cb5360b1e38181a4e5a8c1236f3476fec3b2"
  license "LGPL-2.1-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6d745738966280ada96646e89adff3f1891d5d644843303ff4bc350ef17638a5"
  end

  depends_on "automake" => :build
  depends_on "pkgconf" => :test
  depends_on "gmp"
  depends_on "mpfr"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"m1.fplll").write("[[10 11][11 12]]")
    assert_equal "[[0 1 ]\n[1 0 ]\n]\n", `#{bin/"fplll"} m1.fplll`

    (testpath/"m2.fplll").write("[[17 42 4][50 75 108][11 47 33]][100 101 102]")
    assert_equal "[107 88 96]\n", `#{bin/"fplll"} -a cvp m2.fplll`

    (testpath/"test.cpp").write <<~CPP
      #include <fplll.h>
      #include <vector>
      #include <stdio.h>
      using namespace fplll;
      int main(int c, char **v) {
        ZZ_mat<mpz_t> b;
        std::vector<Z_NR<mpz_t>> sol_coord;
        if (c > 1) { // just a compile test
           shortest_vector(b, sol_coord);
        }
        return 0;
      }
    CPP
    pkgconf_flags = shell_output("pkgconf --cflags --libs gmp mpfr fplll").chomp.split
    system ENV.cxx, "-std=c++11", "test.cpp", *pkgconf_flags, "-o", "test"
    system "./test"
  end
end
