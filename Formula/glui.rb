class Glui < Formula
  desc "C++ user interface library"
  homepage "https://github.com/libglui/glui"
  url "https://github.com/libglui/glui/archive/refs/tags/2.37.tar.gz"
  sha256 "f7f6983f7410fe8dfaa032b2b7b1aac2232ec6a400a142b73f680683dad795f8"
  license "Zlib"
  revision 1



  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4139a08a5de64bf1f5f432e506fd48ed9a39464d8e248d90a46c91523daa4335"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "freeglut"
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  # Fix compiler warnings in glui.h. Merged into master on November 28, 2016.
  patch do
    url "https://github.com/libglui/glui/commit/fc9ad76733034605872a0d1323bb19cbc23d87bf.patch?full_index=1"
    sha256 "b1afada854f920692ab7cb6b6292034f3488936c4332e3e996798ee494a3fdd7"
    type :backport
    resolves "https://github.com/libglui/glui/pull/55"
  end

  # Backport fix for CMake build linking on macOS
  patch do
    url "https://github.com/libglui/glui/commit/eaca63aea72ed4db055514dfec2abc71a106aa70.patch?full_index=1"
    sha256 "81cd6400037f9082ffd2926a01458c40c0d81c71cb7786cb667909ef64b1541b"
    type :backport
    resolves "https://github.com/libglui/glui/pull/54"
  end

  # Backport support for CMake install
  patch do
    url "https://github.com/libglui/glui/commit/4299e8fa43bb1e67370be36cad4b21115ab88af9.patch?full_index=1"
    sha256 "9070d9a3f44ffd3787762125fb194d92e24a9bc0b5e27bc5571ac09718199404"
    type :backport
    resolves "https://github.com/libglui/glui/pull/60"
  end

  deny_network_access!
  def install
    # Find framework first to avoid linking to XQuartz libraries if installed
    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
                    *std_cmake_args(find_framework: "FIRST")
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    if OS.mac?
      (testpath/"test.cpp").write <<~CPP
        #include <cassert>
        #include <GL/glui.h>
        int main() {
          glutDisplayFunc([](){});
          GLUI *glui = GLUI_Master.create_glui("GLUI");
          assert(glui != nullptr);
          return 0;
        }
      CPP
      system ENV.cxx, "-framework", "GLUT", "-framework", "OpenGL", "-I#{include}",
        "-L#{lib}", "-lglui", "-std=c++11", "test.cpp"

      # GLUT needs a WindowServer connection, which the test sandbox denies
      return
    else
      (testpath/"test.cpp").write <<~CPP
        #include <cassert>
        #include <GL/glui.h>
        #include <GL/glut.h>
        int main(int argc, char **argv) {
          glutInit(&argc, argv);
          glutDisplayFunc([](){});
          GLUI *glui = GLUI_Master.create_glui("GLUI");
          assert(glui != nullptr);
          return 0;
        }
      CPP
      system ENV.cxx, "-I#{include}", "-std=c++11", "test.cpp",
        "-L#{lib}", "-lglui", "-lglut", "-lGLU", "-lGL"
      if ENV["DISPLAY"]
        # Fails without X display: freeglut (./a.out): failed to open display ''
        system "./a.out"
      end
    end
  end
end
