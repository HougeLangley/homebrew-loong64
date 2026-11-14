class Igraph < Formula
  desc "Network analysis package"
  homepage "https://igraph.org/"
  url "https://github.com/igraph/igraph/releases/download/1.0.1/igraph-1.0.1.tar.gz"
  sha256 "969f2d7d22f67e788d8638c9a8c96615f50d7819c08978b3ef4a787bb6daa96c"
  license "GPL-2.0-or-later"



  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ef6fc32707191a6fbb44a54a2e8df2a4d2f6c24a1b5b49568653d950b3c728b8"
  end

  depends_on "cmake" => :build
  depends_on "arpack"
  depends_on "glpk"
  depends_on "gmp"
  depends_on "openblas"

  uses_from_macos "libxml2"

  deny_network_access!

  def install
    # explanation of extra options:
    # * we want a shared library, not a static one
    # * link-time optimization should be enabled if the compiler supports it
    # * thread-local storage of global variables is enabled
    # * force the usage of external dependencies from Homebrew where possible
    # * GraphML support should be compiled in (needs libxml2)
    # * BLAS and LAPACK should come from OpenBLAS
    # * prevent the usage of ccache even if it is installed to ensure that we
    #    have a clean build
    # * OpenMP is not auto-detected from the `libomp` that `openblas` pulls in
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DIGRAPH_ENABLE_LTO=AUTO
      -DIGRAPH_ENABLE_TLS=ON
      -DIGRAPH_GLPK_SUPPORT=ON
      -DIGRAPH_GRAPHML_SUPPORT=ON
      -DIGRAPH_OPENMP_SUPPORT=OFF
      -DIGRAPH_USE_INTERNAL_ARPACK=OFF
      -DIGRAPH_USE_INTERNAL_BLAS=OFF
      -DIGRAPH_USE_INTERNAL_GLPK=OFF
      -DIGRAPH_USE_INTERNAL_GMP=OFF
      -DIGRAPH_USE_INTERNAL_LAPACK=OFF
      -DBLA_VENDOR=OpenBLAS
      -DUSE_CCACHE=OFF
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <igraph.h>
      int main(void) {
          igraph_real_t diameter;
          igraph_t graph;
          igraph_setup();
          igraph_rng_seed(igraph_rng_default(), 42);
          igraph_erdos_renyi_game_gnp(&graph, 1000, 5.0/1000, IGRAPH_UNDIRECTED, IGRAPH_SIMPLE_SW, IGRAPH_EDGE_UNLABELED);
          igraph_diameter(&graph, NULL, &diameter, NULL, NULL, NULL, NULL, IGRAPH_UNDIRECTED, /*unconn=*/ true);
          printf("Diameter = %g\\n", (double) diameter);
          igraph_destroy(&graph);
          return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}/igraph", "-L#{lib}",
                   "-ligraph", "-lm", "-o", "test"
    assert_match "Diameter = 8", shell_output("./test")
  end
end
