class Chaiscript < Formula
  desc "Easy to use embedded scripting language for C++"
  homepage "https://chaiscript.com/"
  url "https://github.com/ChaiScript/ChaiScript/archive/refs/tags/v6.1.0.tar.gz"
  sha256 "3ca9ba6434b4f0123b5ab56433e3383b01244d9666c85c06cc116d7c41e8f92a"
  license "BSD-3-Clause"
  head "https://github.com/ChaiScript/ChaiScript.git", branch: "develop"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4318ea5243abd67d03ebb3ff34183aee87d1f0c3ae55aaa236da26a348425c37"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # Workaround to build with CMake 4
    args = %w[-DCMAKE_POLICY_VERSION_MINIMUM=3.5]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <chaiscript/chaiscript.hpp>
      #include <chaiscript/chaiscript_stdlib.hpp>
      #include <cassert>

      int main() {
        chaiscript::ChaiScript chai;
        assert(chai.eval<int>("123") == 123);
      }
    CPP

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-ldl", "-lpthread", "-std=c++14", "-o", "test"
    system "./test"
  end
end
