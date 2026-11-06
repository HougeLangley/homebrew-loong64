class Liboauth < Formula
  desc "C library for the OAuth Core RFC 5849 standard"
  homepage "https://sourceforge.net/projects/liboauth/"
  url "https://downloads.sourceforge.net/project/liboauth/liboauth-1.0.3.tar.gz"
  sha256 "0df60157b052f0e774ade8a8bac59d6e8d4b464058cc55f9208d72e41156811f"
  # if configured with '--enable-gpl' see COPYING.GPL and LICENSE.OpenSSL
  # otherwise read COPYING.MIT
  license "MIT"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "4ebd6450983b9205522df2be9e4cebac22e6bf7bf0f4cbe54ea1dac4736f962c"
  end

  revision 4


  depends_on "openssl@4"

  # Patch for compatibility with OpenSSL 1.1
  patch :p0 do
    url "https://raw.githubusercontent.com/freebsd/freebsd-ports/121e6c77a8e6b9532ce6e45c8dd8dbf38ca4f97d/net/liboauth/files/patch-src_hash.c"
    sha256 "a7b0295dab65b5fb8a5d2a9bbc3d7596b1b58b419bd101cdb14f79aa5cc78aea"
    type :unofficial
  end

  # Fix -flat_namespace being used on Big Sur and later.
  patch do
    file "Patches/libtool/configure-pre-0.4.2.418-big_sur.diff"
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-curl"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stddef.h>
      #include <oauth.h>
      #include <stdlib.h>
      #include <string.h>

      int main(void) {
        char *escaped = oauth_url_escape("hello world!");
        int failed = !escaped || strcmp(escaped, "hello%20world%21") != 0;
        free(escaped);
        return failed;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-loauth", "-o", "test"
    system "./test"
  end
end
