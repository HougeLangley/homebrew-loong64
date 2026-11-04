class DvdxrwTools < Formula
  desc "DVD+-RW/R tools"
  # Original URL no longer accessible: https://fy.chalmers.se/~appro/linux/DVD+RW/
  homepage "https://en.wikipedia.org/wiki/Dvd+rw-tools"
  url "https://deb.debian.org/debian/pool/main/d/dvd+rw-tools/dvd+rw-tools_7.1.orig.tar.gz"
  mirror "https://fy.chalmers.se/~appro/linux/DVD+RW/tools/dvd+rw-tools-7.1.tar.gz"
  sha256 "f8d60f822e914128bcbc5f64fbe3ed131cbff9045dca7e12c5b77b26edde72ca"
  license "GPL-2.0-only"

  livecheck do
    skip "No longer developed or maintained"
  end


  uses_from_macos "m4" => :build

  # Apply Fedora patch for missing header on Linux
  patch do
    on_linux do
      url "https://src.fedoraproject.org/rpms/dvd+rw-tools/raw/938529cda09efcc2f79478be1632648adc3537af/f/dvd+rw-tools-7.1-sysmacro-inc.patch"
      sha256 "28a69bb73c5d819cb445add766e1d68134dc0ec26fe83cc87164ec4853c9541d"
      type :unofficial
    end
  end

  # Respect $prefix on macOS.
  # Fix build failure because of missing #include <limits.h> on Linux.
  # Patch submitted to author by email.
  patch :DATA

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fa0f3132120a862e5b25074e5aea7f67d60ac81ff5ca4e4179cdcd8b92c76a19"
  end

  def install
    ENV.append "CXXFLAGS", "-Wno-reserved-user-defined-literal" if DevelopmentTools.clang_build_version >= 1700
    bin.mkpath
    man1.mkpath
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    exit_code = if OS.mac?
      134
    else
      143
    end
    assert_match "unable to open", shell_output("#{bin}/dvd+rw-mediainfo /dev/null 2>&1", exit_code)
  end
end

__END__
diff --git a/Makefile.m4 b/Makefile.m4
index a6a100b..03fc245 100644
--- a/Makefile.m4
+++ b/Makefile.m4
@@ -27,11 +27,13 @@ CXXFLAGS+=$(WARN) -D__unix -O2 -fno-exceptions
 LDLIBS	=-framework CoreFoundation -framework IOKit
 LINK.o	=$(LINK.cc)

+prefix?=/usr
+
 # to install set-root-uid, `make BIN_MODE=04755 install'...
 BIN_MODE?=0755
 install:	dvd+rw-tools
-	install -o root -m $(BIN_MODE) $(CHAIN) /usr/bin
-	install -o root -m 0644 growisofs.1 /usr/share/man/man1
+	install -m $(BIN_MODE) $(CHAIN) $(prefix)/bin
+	install -m 0644 growisofs.1 $(prefix)/share/man/man1
 ])

 ifelse(OS,MINGW32,[
diff --git a/transport.hxx b/transport.hxx
index 35a57a7..467ce50 100644
--- a/transport.hxx
+++ b/transport.hxx
@@ -16,6 +16,7 @@
 #include <fcntl.h>
 #include <poll.h>
 #include <sys/time.h>
+#include <limits.h>

 inline long getmsecs()
 { struct timeval tv;
