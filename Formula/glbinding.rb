class Glbinding < Formula
  desc "C++ binding for the OpenGL API"
  homepage "https://glbinding.org/"
  url "https://github.com/cginternals/glbinding/archive/refs/tags/v3.5.0.tar.gz"
  sha256 "bb39a97d5d94f70fe6e9c2152e0d8d760758bb031b352e1707fa90f00a43fc69"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "044c716c962ed34007eb516f92b536ed5c679ae53331d82c8c443362ecd3758e"
  end

  head "https://github.com/cginternals/glbinding.git", branch: "master"



  depends_on "cmake" => :build
  depends_on "glfw" => :test

  on_linux do
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  deny_network_access!

  def install
    # Force install to use system directory structure as the upstream only
    # considers /usr and /usr/local to be valid for a system installation
    inreplace "CMakeLists.txt", "set(SYSTEM_DIR_INSTALL FALSE)", "set(SYSTEM_DIR_INSTALL TRUE)"

    system "cmake", "-S", ".", "-B", "build",
                    "-DOPTION_BUILD_OWN_KHR_HEADERS=#{OS.mac? ? "ON" : "OFF"}",
                    "-DEXECUTABLE_INSTALL_RPATH=#{rpath}",
                    "-DLIBRARY_INSTALL_RPATH=#{loader_path}",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <glbinding/gl/gl.h>
      #include <glbinding/glbinding.h>
      #include <GLFW/glfw3.h>
      int main(void)
      {
        glbinding::initialize(glfwGetProcAddress);
      }
    CPP
    open_gl = if OS.mac?
      ["-I#{include}/glbinding/3rdparty", "-framework", "OpenGL"]
    else
      ["-L#{Formula["mesa-glu"].lib}", "-lGL"]
    end
    system ENV.cxx, "-o", "test", "test.cpp", "-std=c++11",
                    "-I#{include}/glbinding", "-I#{lib}/glbinding", *open_gl,
                    "-L#{lib}", "-lglbinding", "-L#{formula_opt_lib("glfw")}", "-lglfw",
                    *ENV.cflags.to_s.split
    system "./test"
  end
end
