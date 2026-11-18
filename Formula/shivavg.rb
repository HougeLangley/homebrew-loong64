class Shivavg < Formula
  desc "OpenGL based ANSI C implementation of the OpenVG standard"
  homepage "https://sourceforge.net/projects/shivavg/"
  url "https://downloads.sourceforge.net/project/shivavg/ShivaVG/0.2.1/ShivaVG-0.2.1.zip"
  sha256 "9735079392829f7aaf79e02ed84dd74f5c443c39c02ff461cfdd19cfc4ae89c4"
  license "LGPL-2.1-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ceac9a633390089e61c3b8e0c711af00e9fb91e7154fab3f714c464486f5258f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_linux do
    depends_on "freeglut"
    depends_on "mesa"
    depends_on "mesa-glu"
  end

  # Apply upstream commit to fix build on Linux. Remove with next release.
  patch do
    url "https://github.com/Ecognize/ShivaVG/commit/fe3bb03d7b03591b26ab7c399f51edcd130f0f4e.patch?full_index=1"
    sha256 "f4eb595afb053eb0a093dcf50748b54e01eff729f4589f82deb8f6f2ce8f571b"
    type :unofficial
    resolves "https://github.com/Ecognize/ShivaVG/issues/12"
  end

  deny_network_access!

  def install
    system "/bin/sh", "autogen.sh"
    # Temporary Homebrew-specific work around for linker flag ordering problem in Ubuntu 16.04.
    # Remove after migration to 18.04.
    inreplace "configure", "$LDFLAGS conftest.$ac_ext", "conftest.$ac_ext $LDFLAGS" unless OS.mac?
    system "./configure", "--with-example-all=no", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <vg/openvg.h>
      #ifdef __APPLE__
      #include <OpenGL/OpenGL.h>
      #else
      #include <EGL/egl.h>
      #include <EGL/eglext.h>
      #endif

      /* an offscreen GL context needs no display, so the test works headless */
      static int create_gl_context(void) {
      #ifdef __APPLE__
        CGLPixelFormatAttribute attrs[] = { kCGLPFAAllowOfflineRenderers, (CGLPixelFormatAttribute)0 };
        CGLPixelFormatObj pix;
        GLint npix;
        CGLContextObj ctx;
        return CGLChoosePixelFormat(attrs, &pix, &npix) == kCGLNoError && npix > 0 &&
               CGLCreateContext(pix, NULL, &ctx) == kCGLNoError && CGLSetCurrentContext(ctx) == kCGLNoError;
      #else
        PFNEGLGETPLATFORMDISPLAYEXTPROC get_display =
          (PFNEGLGETPLATFORMDISPLAYEXTPROC)eglGetProcAddress("eglGetPlatformDisplayEXT");
        EGLDisplay dpy = get_display(EGL_PLATFORM_SURFACELESS_MESA, EGL_DEFAULT_DISPLAY, NULL);
        if (dpy == EGL_NO_DISPLAY || !eglInitialize(dpy, NULL, NULL) || !eglBindAPI(EGL_OPENGL_API))
          return 0;
        EGLContext ctx = eglCreateContext(dpy, EGL_NO_CONFIG_KHR, EGL_NO_CONTEXT, NULL);
        return ctx != EGL_NO_CONTEXT && eglMakeCurrent(dpy, EGL_NO_SURFACE, EGL_NO_SURFACE, ctx);
      #endif
      }

      int main(void) {
        if (!create_gl_context()) return 1;
        if (vgCreateContextSH(64, 64) != VG_TRUE) return 2;
        printf("%s\\n", (const char *)vgGetString(VG_VENDOR));
        vgDestroyContextSH();
        return 0;
      }
    C

    flags = %W[-I#{include} -L#{lib} -lOpenVG]
    flags += if OS.mac?
      %w[-framework OpenGL -Wno-deprecated-declarations]
    else
      %W[
        -I#{formula_opt_include("mesa")} -L#{formula_opt_lib("mesa")}
        -L#{formula_opt_lib("mesa-glu")} -lEGL -lGLU -lGL
      ]
    end
    system ENV.cc, "test.c", "-o", "test", *flags
    assert_equal "Ivan Leben", shell_output("./test").strip
  end
end
