class Voroxx < Formula
  desc "3D Voronoi cell software library"
  homepage "https://math.lbl.gov/voro++"
  url "https://math.lbl.gov/voro++/download/dir/voro++-0.4.6.tar.gz"
  sha256 "ef7970071ee2ce3800daa8723649ca069dc4c71cc25f0f7d22552387f3ea437e"
  license "BSD-3-Clause"
  revision 2

  livecheck do
    url "https://math.lbl.gov/voro++/download/"
    regex(/href=.*?voro\+\+[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "effa0cdb12790fe7b9f81d3ac65a8c417b923fbb0b44859d117ab7fb252e5eca"
  end

  def install
    inreplace "config.mk", "CFLAGS=", "CFLAGS=-fPIC " if OS.linux?
    system "make", "install", "PREFIX=#{prefix}"
    pkgshare.install("examples")
    mv prefix/"man", share/"man"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "voro++.hh"
      double rnd() { return double(rand())/RAND_MAX; }
      int main() {
        voro::container con(0, 1, 0, 1, 0, 1, 6, 6, 6, false, false, false, 8);
        for (int i = 0; i < 20; i++) con.put(i, rnd(), rnd(), rnd());
        if (fabs(con.sum_cell_volumes() - 1) > 1.e-8) abort();
        con.draw_cells_gnuplot("test.gnu");
      }
    CPP
    system ENV.cxx, "test.cpp", "-I#{include}/voro++", "-L#{lib}",
                    "-lvoro++"
    system "./a.out"
    assert_path_exists testpath/"test.gnu"
  end
end
