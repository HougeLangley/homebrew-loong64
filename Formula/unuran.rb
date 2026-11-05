class Unuran < Formula
  desc "UNU.RAN - Universal Non-Uniform RANdom number generator"
  homepage "https://statmath.wu.ac.at/unuran/"
  url "https://github.com/unuran/unuran/archive/refs/tags/unuran-1.12.0.tar.gz"
  sha256 "9c8f6c5229615dc4871af11bca92fab9083f45ab66871d98031e05578e0567f9"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "81a14725be5ab9a8f7f33ee262fc3ea8575ccbac194fe7111492babe91241048"
  end

  compatibility_version 1
  head "https://github.com/unuran/unuran.git", branch: "main"

  livecheck do
    url :stable
    regex(/^unuran[._-](\d+(?:\.\d+)+)$/i)
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "texinfo" => :build
  depends_on "gsl"

  def install
    # force autogen.sh to look for and use our glibtoolize
    inreplace "autogen.sh", "libtoolize", "glibtoolize"
    system "./autogen.sh", "--enable-shared", "--with-urng-gsl", *std_configure_args
    system "make"
    # system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <unuran.h>
      int main() {
          UNUR_DISTR *par = unur_distr_normal(NULL, 0);
          if (par == NULL) return 1;
          return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{formula_opt_lib("gsl")}", "-L#{lib}",
            "-lgsl", "-lgslcblas", "-lunuran", "-o", "test"
    system "./test"
  end
end
