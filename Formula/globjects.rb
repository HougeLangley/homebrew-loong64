class Globjects < Formula
  desc "C++ library strictly wrapping OpenGL objects"
  homepage "https://globjects.org/"
  license "MIT"
  revision 1

  # TODO: Switch to `glbinding` with v2 release and remove stable/head blocks.
  # Also consider deprecating `glbinding@2` based on upstream support status.
  stable do
    url "https://github.com/cginternals/globjects/archive/refs/tags/v1.1.0.tar.gz"
    sha256 "68fa218c1478c09b555e44f2209a066b28be025312e0bab6e3a0b142a01ebbc6"
    depends_on "glbinding@2"
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9fde77c35a583529481584e9e765fb00f8e71e6cd6317b8e5f7a9ae50f3c1e15"
  end

  head do
    url "https://github.com/cginternals/globjects.git", branch: "master"
    depends_on "glbinding"
  end

  # Last release on 2016-11-18. Also removed by Debian 13 / Ubuntu 26.04
  deprecate! date: "2026-05-18", because: :unmaintained
  disable! date: "2027-05-18", because: :unmaintained


  depends_on "cmake" => :build
  depends_on "glm"

  def install
    # Force install to use system directory structure as the upstream only
    # considers /usr and /usr/local to be valid for a system installation
    inreplace "CMakeLists.txt", "set(SYSTEM_DIR_INSTALL FALSE)", "set(SYSTEM_DIR_INSTALL TRUE)"

    system "cmake", "-S", ".", "-B", "build",
                    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5",
                    "-DOPTION_BUILD_TESTS=OFF",
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <globjects/globjects.h>
      int main(void)
      {
        globjects::init();
      }
    CPP
    flags = ["-std=c++11"]
    flags << "-stdlib=libc++" if OS.mac?
    system ENV.cxx, "-o", "test", "test.cpp", *flags,
                    "-I#{include}/globjects",
                    "-I#{formula_opt_include("glbinding@2")}",
                    "-I#{formula_opt_include("glm")}/glm",
                    "-L#{lib}", "-L#{formula_opt_lib("glbinding@2")}",
                    "-lglobjects", "-lglbinding", *ENV.cflags.to_s.split
    system "./test"
  end
end
