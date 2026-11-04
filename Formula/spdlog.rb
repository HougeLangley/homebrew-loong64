class Spdlog < Formula
  desc "Super fast C++ logging library"
  homepage "https://github.com/gabime/spdlog"
  url "https://github.com/gabime/spdlog/archive/refs/tags/v1.17.0.tar.gz"
  sha256 "d8862955c6d74e5846b3f580b1605d2428b11d97a410d86e2fb13e857cd3a744"
  license "MIT"
  compatibility_version 1
  head "https://github.com/gabime/spdlog.git", branch: "v1.x"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a73a8709ec07d0433398b1ed86daddb28642d47949f948e150409bce34b9f97b"
  end

  depends_on "cmake" => :build
  depends_on "fmt"

  deny_network_access!

  def install
    ENV.cxx11

    inreplace "include/spdlog/tweakme.h", "// #define SPDLOG_FMT_EXTERNAL", <<~C
      #ifndef SPDLOG_FMT_EXTERNAL
      #define SPDLOG_FMT_EXTERNAL
      #endif
    C

    args = std_cmake_args + %W[
      -Dpkg_config_libdir=#{lib}
      -DSPDLOG_BUILD_BENCH=OFF
      -DSPDLOG_BUILD_EXAMPLE=OFF
      -DSPDLOG_BUILD_TESTS=OFF
      -DSPDLOG_FMT_EXTERNAL=ON
    ]
    system "cmake", "-S", ".", "-B", "build", "-DSPDLOG_BUILD_SHARED=ON", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
    system "cmake", "-S", ".", "-B", "build", "-DSPDLOG_BUILD_SHARED=OFF", *args
    system "cmake", "--build", "build"
    lib.install "build/libspdlog.a"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "spdlog/sinks/basic_file_sink.h"
      #include <iostream>
      #include <memory>
      int main()
      {
        try {
          auto console = spdlog::basic_logger_mt("basic_logger", "#{testpath}/basic-log.txt");
          console->info("Test");
        }
        catch (const spdlog::spdlog_ex &ex)
        {
          std::cout << "Log init failed: " << ex.what() << std::endl;
          return 1;
        }
      }
    CPP

    system ENV.cxx, "-std=c++11", "test.cpp", "-I#{include}", "-L#{formula_opt_lib("fmt")}", "-lfmt", "-o", "test"
    system "./test"
    assert_path_exists testpath/"basic-log.txt"
    assert_match "Test", (testpath/"basic-log.txt").read
  end
end
