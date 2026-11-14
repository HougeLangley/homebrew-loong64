class Cbc < Formula
  desc "Mixed integer linear programming solver"
  homepage "https://github.com/coin-or/Cbc"
  url "https://github.com/coin-or/Cbc/archive/refs/tags/releases/2.10.13.tar.gz"
  sha256 "62fde44dcf6f3d05c5cd291d7435cdd1b7e8acd3c78ec481dd39fe49cbc40399"
  license "EPL-2.0"
  compatibility_version 1

  livecheck do
    url :stable
    regex(%r{^releases/v?(\d+(?:\.\d+)+)$}i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f7e89616e91acb383c47134ce02d10c695c9aa4e10829d2231e487e5f7a303ed"
  end

  depends_on "pkgconf" => [:build, :test]

  depends_on "cgl"
  depends_on "clp"
  depends_on "coinutils"
  depends_on "osi"

  on_macos do
    depends_on "openblas"
  end

  conflicts_with "libcouchbase", because: "both install `cbc` binaries"

  deny_network_access!

  def install
    # Work around for:
    # Error 1: "mkdir: #{include}/cbc/coin: File exists."
    (include/"cbc/coin").mkpath

    system "./configure", "--disable-silent-rules",
                          "--includedir=#{include}/cbc",
                          "--enable-cbc-parallel",
                          *std_configure_args
    system "make", "install"

    pkgshare.install "Cbc/examples"
  end

  test do
    cp_r pkgshare/"examples/.", testpath

    pkg_config_flags = shell_output("pkg-config --cflags --libs cbc").chomp.split
    system ENV.cxx, "-std=c++11", "sudoku.cpp", *pkg_config_flags, "-o", "sudoku"
    assert_match "solution is valid", shell_output("./sudoku")
  end
end
