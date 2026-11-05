class Superlu < Formula
  desc "Solve large, sparse nonsymmetric systems of equations"
  homepage "https://portal.nersc.gov/project/sparse/superlu/"
  url "https://github.com/xiaoyeli/superlu/archive/refs/tags/v7.0.1.tar.gz"
  sha256 "86dcca1e086f8b8079990d07f00eb707fc9ef412cf3b2ce808b37956f0de2cb8"
  license "BSD-3-Clause-LBNL"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "727138383b2b34ad8ce7997f584d61d7737517ced17fb01a12ff7692c4db2f1f"
  end



  depends_on "cmake" => :build
  depends_on "pkgconf" => :test
  depends_on "openblas"

  deny_network_access!

  def install
    args = %W[
      -Denable_internal_blaslib=NO
      -DTPL_BLAS_LIBRARIES=#{formula_opt_lib("openblas")}/#{shared_library("libopenblas")}
      -DBUILD_SHARED_LIBS=YES
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Source and data for test
    pkgshare.install "EXAMPLE/dlinsol.c"
    pkgshare.install "EXAMPLE/g20.rua"
  end

  test do
    pkgconf_cflags = shell_output("pkgconf --cflags --libs superlu").chomp.split
    system ENV.cc, pkgshare/"dlinsol.c", *pkgconf_cflags, "-o", "test"
    assert_match "No of nonzeros in L+U = 11886", pipe_output("./test", (pkgshare/"g20.rua").read, 0)
  end
end
