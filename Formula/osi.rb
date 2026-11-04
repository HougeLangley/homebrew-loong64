class Osi < Formula
  desc "Open Solver Interface"
  homepage "https://github.com/coin-or/Osi"
  url "https://github.com/coin-or/Osi/archive/refs/tags/releases/0.108.12.tar.gz"
  sha256 "1d80d0b4275f2e1ceefc6dda66b8616e3a8c8b07a926ef4456db4a0d55249333"
  license "EPL-2.0"
  compatibility_version 1

  livecheck do
    url :stable
    regex(%r{^releases/v?(\d+(?:\.\d+)+)$}i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b008e790f6c6811ff76ab4a8a36706c1884b74c8c2d8891ab6a52fb31577a756"
  end

  depends_on "pkgconf" => :build
  depends_on "coinutils"

  on_macos do
    depends_on "openblas"
  end

  def install
    # Work around - same as clp formula
    # Error 1: "mkdir: #{include}/osi/coin: File exists."
    mkdir include/"osi/coin"

    system "./configure", "--disable-silent-rules", "--includedir=#{include}/osi", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <OsiSolverInterface.hpp>

      int main() {
        OsiSolverInterface *si;
      }
    CPP
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lOsi",
                    "-I#{include}/osi/coin",
                    "-I#{formula_opt_include("coinutils")}/coinutils/coin",
                    "-o", "test"
    system "./test"
  end
end
