class Jinx < Formula
  desc "Embeddable scripting language for real-time applications"
  homepage "https://jamesboer.github.io/Jinx/"
  url "https://github.com/JamesBoer/Jinx/archive/refs/tags/v1.3.11.tar.gz"
  sha256 "58ca494e965b799e7296c4dc98936230fdc97f0072e78d6f658c976c0cfaa6f5"
  license "MIT"
  head "https://github.com/JamesBoer/Jinx.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7bf0d975f95ad8d80446ea1f244ee8c0f07317339ce8112868cbf1225e7a8556"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    # disable building tests
    inreplace "CMakeLists.txt", "if(NOT jinx_is_subproject)", "if(FALSE)"

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    lib.install "build/libJinx.a"

    include.install Dir["Source/*.h"]
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "Jinx.h"

      int main() {
        // Create the Jinx runtime object
        auto runtime = Jinx::CreateRuntime();

        // Text containing our Jinx script
        const char * scriptText =
        u8R"(

        -- Use the core library
        import core

        -- Write to the debug output
        write line "Hello, world!"

        )";

        // Create and execute a script object
        auto script = runtime->ExecuteScript(scriptText);
      }
    CPP
    system ENV.cxx, "-std=c++17", "test.cpp", "-I#{include}", "-L#{lib}", "-lJinx", "-o", "test"
    assert_match "Hello, world!", shell_output("./test")
  end
end
