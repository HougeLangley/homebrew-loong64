class Libnetworkit < Formula
  desc "NetworKit is an OS-toolkit for large-scale network analysis"
  homepage "https://networkit.github.io"
  url "https://github.com/networkit/networkit/archive/refs/tags/11.2.2.tar.gz"
  sha256 "04fffd0f801a91524a6dc2643f7d262e79600b086e4688bcb1b7988b2b5448dd"
  license "MIT"

  livecheck do
    formula "networkit"
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "df6501f30d1f2ba6d47a4aac74f1308b676d158e92cc1b6c69302509368efe58"
  end

  depends_on "cmake" => :build
  depends_on "tlx"
  depends_on "ttmath"

  on_macos do
    depends_on "libomp"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DNETWORKIT_EXT_TLX=#{formula_opt_prefix("tlx")}",
                    "-DNETWORKIT_CXX_STANDARD=20",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <networkit/graph/Graph.hpp>
      int main()
      {
        // Try to create a graph with five nodes
        NetworKit::Graph g(5);
        return 0;
      }
    CPP
    omp_flags = OS.mac? ? ["-I#{formula_opt_include("libomp")}"] : []
    system ENV.cxx, "-std=c++20", "test.cpp", "-L#{lib}", "-lnetworkit", "-o", "test", *omp_flags
    system "./test"
  end
end
