class Rttr < Formula
  desc "C++ Reflection Library"
  homepage "https://www.rttr.org"
  url "https://github.com/rttrorg/rttr/releases/download/v0.9.6/rttr-0.9.6-src.zip"
  sha256 "d6853be1bfc38da6fb4512ae4c0a116662f86fa81a6b2aab1c4dada2c16f375f"
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "32d6124b07aa317cbd4aa32265eaa6ddc70c9eb5982a08425d5ac34eda1fa8d3"
  end

  head "https://github.com/rttrorg/rttr.git", branch: "master"


  depends_on "cmake" => :build

  deny_network_access!

  def install
    args = %w[
      -DBUILD_DOCUMENTATION=OFF
      -DBUILD_UNIT_TESTS=OFF
      -DCMAKE_CXX_FLAGS=-Wno-deprecated-declarations
    ]

    # Workaround to build with CMake 4
    args << "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"

    # AOSC rapidjson 0001: assigning const members is invalid C++ and is
    # diagnosed by GCC 15+ during template instantiation.
    rapidjson_header = "3rd_party/rapidjson-1.1.0/rapidjson/document.h"
    raise "bundled rapidjson document.h not found" unless File.exist?(rapidjson_header)
    inreplace rapidjson_header, /^\s*GenericStringRef& operator=.*\n/, ""

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    hello_world = "Hello World"
    (testpath/"test.cpp").write <<~CPP
      #include <iostream>
      #include <rttr/registration>

      static void f() { std::cout << "#{hello_world}" << std::endl; }
      using namespace rttr;
      RTTR_REGISTRATION
      {
          using namespace rttr;
          registration::method("f", &f);
      }
      int main()
      {
          type::invoke("f", {});
      }
      // outputs: "Hello World"
    CPP
    system ENV.cxx, "-std=c++11", "test.cpp", "-L#{lib}", "-lrttr_core", "-o", "test"
    assert_match hello_world, shell_output("./test")
  end
end
