class Vncsnapshot < Formula
  desc "Command-line utility for taking VNC snapshots"
  homepage "https://sourceforge.net/projects/vncsnapshot/"
  url "https://downloads.sourceforge.net/project/vncsnapshot/vncsnapshot/1.2a/vncsnapshot-1.2a-src.tar.gz"
  sha256 "20f5bdf6939a0454bc3b41e87e41a5f247d7efd1445f4fac360e271ddbea14ee"
  license "GPL-2.0-or-later"
  revision 2

  livecheck do
    url :stable
    regex(%r{url=.*?/vncsnapshot[._-]v?(\d+(?:\.\d+)+[a-z]?)-src\.t}i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3f88e45537ce5455845dc636f6cfecbe79bc4e80332a1560feba86c10d4460a9"
  end

  depends_on "jpeg-turbo"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  patch :DATA # remove old PPC __APPLE__ ifdef from sockets.cxx

  allow_network_access! :test

  def install
    # From Ubuntu
    inreplace "rfb.h", "typedef unsigned long CARD32;",
                       "typedef unsigned int CARD32;"

    args = [
      "JPEG_INCLUDE=-I#{formula_opt_include("jpeg-turbo")}",
      "JPEG_LIB=-L#{formula_opt_lib("jpeg-turbo")} -ljpeg",
    ]
    if OS.linux?
      args << "ZLIB_INCLUDE=-I#{formula_opt_include("zlib-ng-compat")}"
      args << "ZLIB_LIB=-L#{formula_opt_lib("zlib-ng-compat")} -lz"
    end

    ENV.deparallelize
    system "make",
           "CC=#{ENV.cc} -std=gnu17 -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration",
           "CXX=#{ENV.cxx} -std=gnu++17 -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration",
           *args
    bin.install "vncsnapshot", "vncpasswd"
    man1.install "vncsnapshot.man1" => "vncsnapshot.1"
  end

  test do
    output = shell_output("#{bin}/vncsnapshot 127.0.0.1::#{free_port} out.jpg 2>&1", 1)
    assert_match "Connection refused", output
  end
end

__END__
diff --git a/sockets.cxx b/sockets.cxx
index ecdf0db..6c827fa 100644
--- a/sockets.cxx
+++ b/sockets.cxx
@@ -38,9 +38,9 @@ typedef int socklen_t;
 #include <fcntl.h>
 #endif

-#ifdef __APPLE__
-typedef int socklen_t;
-#endif
+//#ifdef __APPLE__
+//typedef int socklen_t;
+//#endif

 extern "C" {
 #include "vncsnapshot.h"
