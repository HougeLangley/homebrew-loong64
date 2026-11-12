class Mdxmini < Formula
  desc "Plays music in X68000 MDX chiptune format"
  homepage "https://github.com/mistydemeo/mdxmini/"
  url "https://github.com/mistydemeo/mdxmini/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "9b623b365e893a769084f7a2effedc9ece453c6e3861c571ba503f045471a0e0"
  license "GPL-2.0-or-later"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4395a5b04e4b329782c3654ce6025e50735d9f694ae27e7f342b7204235381d2"
  end

  depends_on "sdl2-compat"

  resource "test_song", :test do
    url "https://github.com/vampirefrog/mdxtools/raw/5d14443c57c7f4c9b5220a56e6fdb2334f0c7256/sounds/BOM_01.MDX"
    sha256 "fcb08be1d849bad00d0e81b0e51aea7431413386e4e37f9fb85bddd93518afa4"
  end

  # Fix build on Linux
  patch :DATA

  def install
    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cc}"

    # Makefile doesn't build a dylib
    libmdxmini = shared_library("libmdxmini")

    flags = if OS.mac?
      %W[
        -dynamiclib
        -install_name #{lib/libmdxmini}
        -undefined dynamic_lookup
      ]
    else
      ["-shared"]
    end

    system ENV.cc, *flags, "-o", libmdxmini, *Dir["obj/*.o"]

    bin.install "mdxplay"
    lib.install libmdxmini
    (include/"libmdxmini").install Dir["src/*.h"]
  end

  test do
    resource("test_song").stage testpath
    (testpath/"mdxtest.c").write <<~C
      #include <stdio.h>
      #include "libmdxmini/mdxmini.h"

      int main(int argc, char** argv)
      {
          t_mdxmini mdx;
          char title[100];
          mdx_open(&mdx, argv[1], argv[2]);
          mdx_get_title(&mdx, title);
          printf("%s\\n", title);
      }
    C
    system ENV.cc, "mdxtest.c", "-L#{lib}", "-L#{formula_opt_lib("sdl2-compat")}",
                                "-lmdxmini", "-lSDL2", "-o", "mdxtest", "-lm"

    result = shell_output("#{testpath}/mdxtest #{testpath}/BOM_01.MDX #{testpath}").chomp
    result.force_encoding("ascii-8bit") if result.respond_to? :force_encoding

    l1 = "\x82a\x82n\x82l\x82a\x82d\x82q \x82l\x82`\x82m"
    expected = "#{l1}  [   Music No.01   ] (C)\x82rystem \x82roft  >MDX By \x82\xCB\x82\xCB\x82\xC1\x82\xC6"
    expected.force_encoding("ascii-8bit") if result.respond_to? :force_encoding
    assert_equal expected, result
  end
end

__END__
diff --git a/Makefile b/Makefile
index 9b63041..ff725c3 100644
--- a/Makefile
+++ b/Makefile
@@ -43,6 +43,7 @@ FILES_ORG = COPYING AUTHORS
 LIB = $(OBJDIR)/lib$(TITLE).a

 LIBS += $(LIB)
+LIBS += -lm

 ZIPSRC = $(TITLE)`date +"%y%m%d"`.zip
 TOUCH = touch -t `date +"%m%d0000"`
diff --git a/mak/general.mak b/mak/general.mak
index 6f88e4c..c552eb3 100644
--- a/mak/general.mak
+++ b/mak/general.mak
@@ -17,10 +17,16 @@ CFLAGS = -g -O3
 OBJDIR = obj
 endif

-# iconv
+# iconv and -fPIC flags
 ifneq ($(OS),Windows_NT)
-CFLAGS += -DUSE_ICONV
-LIBS += -liconv
+  UNAME_S := $(shell uname -s)
+  ifeq ($(UNAME_S),Darwin)
+    CFLAGS += -DUSE_ICONV
+    LIBS += -liconv
+  endif
+  ifeq ($(UNAME_S),Linux)
+    CFLAGS += -fPIC
+  endif
 endif

 #
