class LibgrapeLite < Formula
  desc "C++ library for parallel graph processing"
  homepage "https://alibaba.github.io/libgrape-lite/"
  url "https://github.com/alibaba/libgrape-lite/archive/refs/tags/v0.3.5.tar.gz"
  sha256 "77b7f08ad10b26ec7e6f60bf90ab8281208758702a9e8d9dd00b1cd6f5560f39"
  license "Apache-2.0"
  revision 2


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "47ca5f5a1cfed950f7b5674a4df5853b818df78e729ad1def5d2f6f697eb1a40"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "gflags"
  depends_on "glog"
  depends_on "open-mpi"

  # Apply open PR to build with glog >= 0.7.
  patch do
    url "https://github.com/alibaba/libgrape-lite/commit/8093d80574c30c041ecd867ab4a8d74328905b8b.patch?full_index=1"
    sha256 "f31b1c59a2b20f83d254f454d565b6a8c8ea27a024f78efff169563af5c40938"
    type :unofficial
    resolves "https://github.com/alibaba/libgrape-lite/pull/181"
  end

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_POLICY_VERSION_MINIMUM=3.5", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 4.0)
      project(test LANGUAGES CXX)
      find_package(libgrapelite REQUIRED)
      add_executable(test test.cc)
      target_link_libraries(test grape-lite)
    CMAKE

    (testpath/"test.cc").write <<~CPP
      #include <iostream>
      #include <grape/grape.h>

      int main() {
        // init
        grape::InitMPIComm();

        {
          grape::CommSpec comm_spec;
          comm_spec.Init(MPI_COMM_WORLD);
          std::cout << "current worker id: " << comm_spec.worker_id() << std::endl;
        }

        // finalize
        grape::FinalizeMPIComm();
      }
    CPP

    system "cmake", "-S", ".", "-B", "."
    system "cmake", "--build", "."
    assert_equal("current worker id: 0\n", shell_output("./test"))
  end
end
