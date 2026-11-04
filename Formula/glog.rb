class Glog < Formula
  desc "Application-level logging library"
  homepage "https://google.github.io/glog/stable/"
  url "https://github.com/google/glog/archive/refs/tags/v0.7.1.tar.gz"
  sha256 "00e4a87e87b7e7612f519a41e491f16623b12423620006f59f5688bfd8d13b08"
  license "BSD-3-Clause"
  compatibility_version 1
  head "https://github.com/google/glog.git", branch: "master"


  # deprecate! date: "2025-12-10", because: :repo_archived, replacement_formula: "abseil"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "84acaf61e025fdfce96488e9272feefc15fc923d4ffdc262686b0f72c2722461"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "gflags"

  deny_network_access!

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DWITH_PKGCONFIG=ON
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <glog/logging.h>

      int main(int argc, char* argv[]) {
        google::InitGoogleLogging(argv[0]);
        LOG(INFO) << "test";
      }
    CPP

    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 4.0)
      project(test VERSION 1.0)
      find_package(glog CONFIG REQUIRED)
      add_executable(test test.cpp)
      target_link_libraries(test glog::glog)
    CMAKE

    ENV["TMPDIR"] = testpath
    system "cmake", "-S", ".", "-B", "build"
    system "cmake", "--build", "build"
    system "./build/test"

    assert_path_exists testpath/"test.INFO"
    assert_match "test.cpp:5] test", File.read("test.INFO")
  end
end
