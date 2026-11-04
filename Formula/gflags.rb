class Gflags < Formula
  desc "Library for processing command-line flags"
  homepage "https://gflags.github.io/gflags/"
  url "https://github.com/gflags/gflags/archive/refs/tags/v2.3.1.tar.gz"
  sha256 "1b5e0648d7b94021895086e65479b4eaca7935eecfffd7dd9512eb576181c53d"
  license "BSD-3-Clause"
  compatibility_version 1


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e904806728620ec3470f7fdb2838459f1187209a73fd19c21aeb85d425479fc5"
  end

  depends_on "cmake" => [:build, :test]

  deny_network_access!

  def install
    args = %w[
      -DBUILD_SHARED_LIBS=ON
      -DBUILD_STATIC_LIBS=ON
      -DCMAKE_POSITION_INDEPENDENT_CODE=ON
    ]

    system "cmake", "-S", ".", "-B", "_build", *args, *std_cmake_args
    system "cmake", "--build", "_build"
    system "cmake", "--install", "_build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include "gflags/gflags.h"

      DEFINE_bool(verbose, false, "Display program name before message");
      DEFINE_string(message, "Hello world!", "Message to print");

      static bool IsNonEmptyMessage(const char *flagname, const std::string &value)
      {
        return value[0] != '\0';
      }
      DEFINE_validator(message, &IsNonEmptyMessage);

      int main(int argc, char *argv[])
      {
        gflags::SetUsageMessage("some usage message");
        gflags::SetVersionString("1.0.0");
        gflags::ParseCommandLineFlags(&argc, &argv, true);
        if (FLAGS_verbose) std::cout << gflags::ProgramInvocationShortName() << ": ";
        std::cout << FLAGS_message;
        gflags::ShutDownCommandLineFlags();
        return 0;
      }
    CPP
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lgflags", "-o", "test"
    assert_match "Hello world!", shell_output("./test")
    assert_match "Foo bar!", shell_output("./test --message='Foo bar!'")

    (testpath/"CMakeLists.txt").write <<~CMAKE
      cmake_minimum_required(VERSION 4.0)
      project(cmake_test)
      add_executable(${PROJECT_NAME} test.cpp)
      find_package(gflags REQUIRED COMPONENTS static)
      target_link_libraries(${PROJECT_NAME} PRIVATE ${GFLAGS_LIBRARIES})
    CMAKE
    system "cmake", testpath.to_s
    system "cmake", "--build", testpath.to_s
    assert_match "Hello world!", shell_output("./cmake_test")
  end
end
