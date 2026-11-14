class GlbindingAT2 < Formula
  desc "C++ binding for the OpenGL API"
  homepage "https://glbinding.org/"
  url "https://github.com/cginternals/glbinding/archive/refs/tags/v2.1.4.tar.gz"
  sha256 "cb5971b086c0d217b2304d31368803fd2b8c12ee0d41c280d40d7c23588f8be2"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(2(?:\.\d+)+)$/i)
  end


  keg_only :versioned_formula

  # Last release on 2018-02-22
  deprecate! date: "2026-05-18", because: :unmaintained
  disable! date: "2027-05-18", because: :unmaintained


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "740d86e64c572e0303fd4d56fd3e537b852276c7ffe8705cff06f6f7c3606b5b"
  end

  depends_on "cmake" => :build

  on_linux do
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  def install
    # Force install to use system directory structure as the upstream only
    # considers /usr and /usr/local to be valid for a system installation
    inreplace "CMakeLists.txt", "set(SYSTEM_DIR_INSTALL FALSE)", "set(SYSTEM_DIR_INSTALL TRUE)"

    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_INSTALL_RPATH=#{rpath}",
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
                    "-DOPTION_BUILD_TESTS=OFF",
                    "-DOPTION_BUILD_GPU_TESTS=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <glbinding/gl/gl.h>
      #include <glbinding/Binding.h>
      int main(void)
      {
        glbinding::Binding::initialize();
      }
    CPP
    open_gl = OS.mac? ? ["-framework", "OpenGL"] : ["-L#{Formula["mesa-glu"].lib}", "-lGL"]
    system ENV.cxx, "-o", "test", "test.cpp", "-std=c++11",
                    "-I#{include}", *open_gl,
                    "-L#{lib}", "-lglbinding", *ENV.cflags.to_s.split
    system "./test"
  end
end
