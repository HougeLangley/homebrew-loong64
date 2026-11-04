class Openfa < Formula
  desc "Set of algorithms that implement standard models used in fundamental astronomy"
  homepage "https://gitlab.obspm.fr/imcce_openfa/openfa"
  url "https://gitlab.obspm.fr/imcce_openfa/openfa/-/archive/20231011.0.3/openfa-20231011.0.3.tar.gz"
  sha256 "e49de042025537e5cfd9ee55b28e58658efbda05e49fdc1fa90e2d347ee5d696"
  license "BSD-3-Clause"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "93ac539d43f8cebdb52a70a7d85031148117cdff28a3b541bb14b578f9466d08"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %W[
      -DBUILD_SHARED_LIBS=ON
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"testopenfa.c").write <<~C
      #include "openfa.h"
      #include "openfam.h"
      #include <assert.h>

      int main (void) {
        double dj1, dj2, fd;
        int iy, im, id, j;
        dj1 = 2400000.5;
        dj2 = 50123.9999;
        j = openfaJd2cal(dj1, dj2, &iy, &im, &id, &fd);
        assert (iy==1996);
        assert (im==2);
        assert (id==10);
        assert (fd<1.);
        assert (fd>0.99);
        assert (j==0);
        return 0;
      }
    C
    system ENV.cc, "testopenfa.c", "-L#{lib}", "-lopenfa", "-o", "testopenfa"
    system "./testopenfa"
  end
end
