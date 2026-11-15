class MesaGlu < Formula
  desc "Mesa OpenGL Utility library"
  homepage "https://gitlab.freedesktop.org/mesa/glu"
  url "https://archive.mesa3d.org/glu/glu-9.0.3.tar.xz"
  sha256 "bd43fe12f374b1192eb15fe20e45ff456b9bc26ab57f0eee919f96ca0f8a330f"
  license all_of: ["SGI-B-1.1", "SGI-B-2.0"]
  compatibility_version 1
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "d178e918230697d1355fe37ba377401de3b526ef16e0c8c4b1bd8ffcbe6c1cfa"
  end

  head "https://gitlab.freedesktop.org/mesa/glu.git", branch: "master"



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "mesa"

  def install
    system "meson", "setup", "build", "-Dgl_provider=gl", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <GL/glu.h>

      int main(int argc, char* argv[]) {
        static GLUtriangulatorObj *tobj;
        GLdouble vertex[3], dx, dy, len;
        int i = 0;
        int count = 5;
        tobj = gluNewTess();
        gluBeginPolygon(tobj);
        for (i = 0; i < count; i++) {
          vertex[0] = 1;
          vertex[1] = 2;
          vertex[2] = 0;
          gluTessVertex(tobj, vertex, 0);
        }
        gluEndPolygon(tobj);
        return 0;
      }
    CPP
    system ENV.cxx, "-I#{include}", "test.cpp", "-L#{lib}", "-lGLU"
  end
end
