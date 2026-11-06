class Scs < Formula
  desc "Conic optimization via operator splitting"
  homepage "https://web.stanford.edu/~boyd/papers/scs.html"
  url "https://github.com/cvxgrp/scs/archive/refs/tags/3.3.1.tar.gz"
  sha256 "99a1437b2508ed29933d259793a5745f29000fd8ec58f63a8f54a20006aacb86"
  license "MIT"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "00e5a78ae2f2cb97602e91bc7f4ead6add7b6b727208088b2734632c37c0f417"
  end

  on_linux do
    depends_on "openblas"
  end


  def install
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install "test/problems/random_prob"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <rw.h>
      #include <scs.h>
      #include <util.h>
      #include <cones.h>
      int main() {
        ScsData *d; ScsCone *k; ScsSettings *stgs;
        ScsSolution *sol = scs_calloc(1, sizeof(ScsSolution));
        ScsInfo info;
        scs_int result;

        _scs_read_data("#{pkgshare}/random_prob", &d, &k, &stgs);
        result = scs(d, k, stgs, sol, &info);

        _scs_free_data(d); _scs_free_cone(k); _scs_free_sol(sol);
        return result - SCS_SOLVED;
      }
    C
    system ENV.cc, "test.c", "-I#{include}/scs", "-L#{lib}", "-lscsindir",
                   "-o", "testscsindir"
    system "./testscsindir"
    system ENV.cc, "test.c", "-I#{include}/scs", "-L#{lib}", "-lscsdir",
                   "-o", "testscsdir"
    system "./testscsdir"
  end
end
