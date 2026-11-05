class Solid < Formula
  desc "Collision detection library for geometric objects in 3D space"
  homepage "https://github.com/dtecta/solid3/"
  url "https://github.com/dtecta/solid3/archive/ec3e218616749949487f81165f8b478b16bc7932.tar.gz"
  version "3.5.8"
  sha256 "e3a23751ebbad5e35f50e685061f1ab9e1bd3777317efc6912567f55259d0f15"
  license any_of: ["GPL-2.0-only", "QPL-1.0"]

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "cbc8d3959b0e02ee17c34d68528e52ff3007ba36145d2055810ba9360f03c441"
  end

  livecheck do
    skip "No longer developed or maintained"
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_system :linux, macos: :ventura_or_newer do
    depends_on "texinfo" => :build
  end

  # This patch fixes a broken build on clang-600.0.56.
  # Was reported to bugs@dtecta.com (since it also applies to solid-3.5.6)
  patch :DATA

  deny_network_access!

  def install
    # Avoid `required file not found` errors
    touch ["AUTHORS", "ChangeLog", "NEWS"]

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--infodir=#{info}", *std_configure_args

    # Don't make examples, as they do not compile because the include
    # statements for the GLUT library are not platform independent
    inreplace "Makefile", /^(SUBDIRS *=.*) examples( .+)?/, '\1\2'

    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <SOLID/SOLID.h>
      #include <stdio.h>

      int main() {
        DT_ShapeHandle sphere = DT_NewSphere(1.0f);
        DT_ObjectHandle a = DT_CreateObject(NULL, sphere);
        DT_ObjectHandle b = DT_CreateObject(NULL, sphere);
        DT_Vector3 pos = {5.0f, 0.0f, 0.0f};
        DT_SetPosition(b, pos);

        DT_Vector3 p1, p2;
        printf("%.2f\\n", DT_GetClosestPair(a, b, p1, p2));

        DT_DestroyObject(a);
        DT_DestroyObject(b);
        DT_DeleteShape(sphere);
        return 0;
      }
    CPP

    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lsolid", "-o", "test"
    assert_equal "3.00", shell_output("./test").strip
  end
end

__END__
diff --git a/src/complex/DT_CBox.h b/src/complex/DT_CBox.h
index 7fc7c5d..16ce972 100644
--- a/src/complex/DT_CBox.h
+++ b/src/complex/DT_CBox.h
@@ -131,4 +131,6 @@ inline DT_CBox operator-(const DT_CBox& b1, const DT_CBox& b2)
                    b1.getExtent() + b2.getExtent());
 }

+inline DT_CBox computeCBox(MT_Scalar margin, const MT_Transform& xform);
+
 #endif
