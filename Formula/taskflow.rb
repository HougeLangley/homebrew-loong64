class Taskflow < Formula
  desc "General-purpose Task-parallel Programming System using Modern C++"
  homepage "https://taskflow.github.io"
  url "https://github.com/taskflow/taskflow/archive/refs/tags/v4.1.0.tar.gz"
  sha256 "2107f90e315e48a676922010b036357ff2b0c6b9160ce17fa9396e5860b1d715"
  license "MIT"
  head "https://github.com/taskflow/taskflow.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2963b1bef973b9a27f55f4e701ee1acddcc0b6c14cdbb925cfed3e4bf21d788d"
  end

  depends_on "cmake" => :build
  depends_on "make" => :build

  deny_network_access!

  def install
    args = %w[
      -DTF_BUILD_EXAMPLES=OFF
      -DTF_BUILD_TESTS=OFF
    ]

    system "cmake", "-S", ".", "-B", "builddir", *args, *std_cmake_args
    system "cmake", "--build", "builddir"
    system "cmake", "--install", "builddir"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <taskflow/taskflow.hpp>
      int main() {
        tf::Executor executor;
        tf::Taskflow taskflow;
        executor.run(taskflow).wait();
      }
    CPP
    system ENV.cxx, "test.cpp", "-std=c++20", "-pthread", "-o", "test"
    system "./test"
  end
end
