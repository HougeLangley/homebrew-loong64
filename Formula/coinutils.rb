class Coinutils < Formula
  desc "COIN-OR utilities"
  homepage "https://github.com/coin-or/CoinUtils"
  url "https://github.com/coin-or/CoinUtils/archive/refs/tags/releases/2.11.13.tar.gz"
  sha256 "ddfea48e10209215748bc9f90a8c04abbb912b662c1aefaf280018d0a181ef79"
  license "EPL-2.0"
  compatibility_version 1
  head "https://github.com/coin-or/CoinUtils.git", branch: "master"

  livecheck do
    url :homepage
    regex(%r{^(?:releases/)?(\d+(?:\.\d+)+)$}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2c59b2f511e4e316abc822701bbc3cc894e93368255c4a8baf5beff50b9fb436"
  end

  depends_on "pkgconf" => :build
  depends_on "openblas"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  resource "homebrew-coin-or-tools-data-sample-p0201-mps", :test do
    url "https://raw.githubusercontent.com/coin-or-tools/Data-Sample/releases/1.2.11/p0201.mps"
    sha256 "8352d7f121289185f443fdc67080fa9de01e5b9bf11b0bf41087fba4277c07a4"
  end

  deny_network_access!

  def install
    args = [
      "--datadir=#{pkgshare}",
      "--includedir=#{include}/coinutils",
      "--with-blas-incdir=#{formula_opt_include("openblas")}",
      "--with-blas-lib=-L#{formula_opt_lib("openblas")} -lopenblas",
      "--with-lapack-incdir=#{formula_opt_include("openblas")}",
      "--with-lapack-lib=-L#{formula_opt_lib("openblas")} -lopenblas",
    ]

    system "./configure", *args, *std_configure_args
    system "make"
    # Deparallelize due to error 1: "mkdir: #{include}/coinutils/coin: File exists."
    # https://github.com/coin-or/Clp/issues/109
    ENV.deparallelize { system "make", "install" }
  end

  test do
    testpath.install resource("homebrew-coin-or-tools-data-sample-p0201-mps")

    (testpath/"test.cpp").write <<~CPP
      #include <CoinMpsIO.hpp>
      int main() {
        CoinMpsIO mpsIO;
        return mpsIO.readMps("#{testpath}/p0201.mps");
      }
    CPP

    system ENV.cxx, "test.cpp", "-I#{opt_include}/coinutils/coin",
      "-L#{opt_lib}", "-lCoinUtils"
    system "./a.out"
  end
end
