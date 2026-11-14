class Clp < Formula
  desc "Linear programming solver"
  homepage "https://github.com/coin-or/Clp"
  url "https://github.com/coin-or/Clp/archive/refs/tags/releases/1.17.11.tar.gz"
  sha256 "2c078e174dc1a7a308e091b6256fb34b4017897fc140ea707ba207b2913ea46d"
  license "EPL-2.0"
  compatibility_version 1

  livecheck do
    url :stable
    regex(%r{^(?:releases/)?v?(\d+(?:\.\d+)+)$}i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6e40b7194ab1a1384201624bd24d8110fbab1d3127caf3885ce6fc84d5bbbc70"
  end

  depends_on "pkgconf" => [:build, :test]
  depends_on "coinutils"
  depends_on "openblas"
  depends_on "osi"

  resource "coin-or-tools-data-sample-p0033-mps", :test do
    url "https://raw.githubusercontent.com/coin-or-tools/Data-Sample/releases/1.2.12/p0033.mps"
    sha256 "8ccff819023237c79ef32e238a5da9348725ce9a4425d48888baf3a0b3b42628"
  end

  deny_network_access!

  def install
    # Work around https://github.com/coin-or/Clp/issues/109:
    # Error 1: "mkdir: #{include}/clp/coin: File exists."
    mkdir include/"clp/coin"

    args = [
      "--datadir=#{pkgshare}",
      "--disable-silent-rules",
      "--includedir=#{include}/clp",
      "--with-blas-incdir=#{formula_opt_include("openblas")}",
      "--with-blas-lib=-L#{formula_opt_lib("openblas")} -lopenblas",
      "--with-lapack-incdir=#{formula_opt_include("openblas")}",
      "--with-lapack-lib=-L#{formula_opt_lib("openblas")} -lopenblas",
    ]
    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    resource("coin-or-tools-data-sample-p0033-mps").stage testpath
    system bin/"clp", "-import", testpath/"p0033.mps", "-primals"
    (testpath/"test.cpp").write <<~CPP
      #include <ClpSimplex.hpp>
      int main() {
        ClpSimplex model;
        int status = model.readMps("#{testpath}/p0033.mps", true);
        if (status != 0) { return status; }
        status = model.primal();
        return status;
      }
    CPP
    pkg_config_flags = shell_output("pkg-config --cflags --libs clp").chomp.split
    system ENV.cxx, "test.cpp", *pkg_config_flags
    system "./a.out"
  end
end
