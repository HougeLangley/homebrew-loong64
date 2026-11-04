class Libetpan < Formula
  desc "Portable mail library handling several protocols"
  homepage "https://www.etpan.org/libetpan.html"
  url "https://github.com/dinhvh/libetpan/archive/refs/tags/1.10.1.tar.gz"
  sha256 "87bacdc62661a2a7aa5fe9f1f28d2f7c7a53256633ac5129903916c59f80c4c2"
  license "BSD-3-Clause"
  revision 1
  compatibility_version 2
  head "https://github.com/dinhvh/libetpan.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6856be67f7e5adf50d7acbadf1c4053cb4fa37399c82cc32c101c306a621e6dc"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"

  uses_from_macos "cyrus-sasl"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    if build.stable?
      odie "Remove workarounds!" if version > "1.10.1"

      # autoconf 2.71+ probes -std=gnu23 first on modern compilers, which rejects K&R. Force gnu17.
      ENV.append "CFLAGS", "-std=gnu17"

      # https://github.com/dinhvh/libetpan/commit/9919beeea09850364ea966b0d9fb640858bd2b27
      if OS.mac?
        # Keep macOS-native TLS (CFNetwork/Security) compiled in.
        ENV.append "CPPFLAGS", "-DHAVE_CFNETWORK=1"
        ENV.append "LDFLAGS", "-framework CoreFoundation -framework CoreServices -framework Security"
      end
    end

    system "./autogen.sh", "--disable-db", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <libetpan/libetpan.h>
      #include <string.h>
      #include <stdlib.h>

      int main(int argc, char ** argv)
      {
        printf("version is %d.%d",libetpan_get_version_major(), libetpan_get_version_minor());
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-letpan", "-o", "test"
    system "./test"
  end
end
