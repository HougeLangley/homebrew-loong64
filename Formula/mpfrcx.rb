class Mpfrcx < Formula
  desc "Arbitrary precision library for arithmetic of univariate polynomials"
  homepage "https://www.multiprecision.org/mpfrcx/"
  url "https://www.multiprecision.org/downloads/mpfrcx-0.6.3.tar.gz"
  sha256 "9da9b3614c0a3e00e6ed2b82fc935d1c838d97074dc59cb388f8fafbe3db8594"
  license "GPL-3.0-or-later"
  head "https://gitlab.inria.fr/enge/mpfrcx.git", branch: "master"

  livecheck do
    url "https://www.multiprecision.org/mpfrcx/download.html"
    regex(/href=.*?mpfrcx[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "28443e39d5d0f7ed9e48eac459a0f32daad8d633cd8db858966575498ad671e8"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "gmp"
  depends_on "libmpc"
  depends_on "mpfr"

  def install
    # Regenerate configure to avoid building libraries with flat namespaces
    system "autoreconf", "--force", "--install", "--verbose"

    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"

    (pkgshare/"tests").install Dir["tests/tc_*.c"]
  end

  test do
    Dir[pkgshare/"tests/*"].each do |src|
      testname = File.basename(src, ".c")
      system ENV.cc, src, "-I#{include}", "-L#{lib}",
             "-L#{formula_opt_lib("gmp")}", "-L#{formula_opt_lib("libmpc")}", "-L#{formula_opt_lib("mpfr")}",
             "-lmpfrcx", "-lgmp", "-lmpc", "-lmpfr",
             "-o", testname
      system testpath/testname
    end
  end
end
