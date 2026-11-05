class Ucommon < Formula
  desc "GNU C++ runtime library for threads, sockets, and parsing"
  homepage "https://www.gnu.org/software/commoncpp/"
  url "https://ftp.debian.org/debian/pool/main/u/ucommon/ucommon_7.0.1.orig.tar.gz"
  sha256 "99fd0e2c69f24e4ca93d01a14bc3fc4e40d69576f235f80f7a8ab37c16951f3e"
  license all_of: [
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6b08ed508f9159a1b1226bf478a60bb2eb5801da63013ced7a116e689f103b60"
  end

    "LGPL-3.0-or-later",
    "GPL-2.0-or-later" => { with: "mif-exception" },
  ]

  livecheck do
    url "https://ftp.debian.org/debian/pool/main/u/ucommon/"
    regex(/href=.*?ucommon[._-]v?(\d+(?:\.\d+)+)\.orig\.t/i)
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "gnutls"

  on_macos do
    depends_on "gettext"
  end

  # Workaround for macOS 15 SDK adding SO_BINDTODEVICE in sys/socket.h
  patch :DATA

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", "--with-sslstack=gnutls", "--with-pkg-config", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"ucommon-config", "--libs"

    (testpath/"test.cpp").write <<~CPP
      #include <commoncpp/string.h>
      #include <iostream>

      int main() {
        ucommon::String test_string("Hello, Ucommon!");
        std::cout << test_string << std::endl;
        return 0;
      }
    CPP

    system ENV.cxx, "-std=c++11", "test.cpp", "-o", "test", "-I#{include}", "-L#{lib}", "-lucommon"
    system "./test"
  end
end

__END__
diff --git a/corelib/socket.cpp b/corelib/socket.cpp
index 76a52273..04dae257 100644
--- a/corelib/socket.cpp
+++ b/corelib/socket.cpp
@@ -3023,7 +3023,7 @@ int Socket::bindto(socket_t so, const char *host, const char *svc, int protocol)
     if(host && !strcmp(host, "*"))
         host = NULL;
 
-#if defined(SO_BINDTODEVICE) && !defined(__QNX__)
+#if defined(SO_BINDTODEVICE) && !defined(__QNX__) && !defined(__APPLE__)
     if(host && !strchr(host, '.') && !strchr(host, ':')) {
         struct ifreq ifr;
         memset(&ifr, 0, sizeof(ifr));
