class Owamp < Formula
  desc "Implementation of the One-Way Active Measurement Protocol"
  homepage "https://www.internet2.edu/products-services/performance-analytics/performance-tools/"
  url "https://software.internet2.edu/sources/owamp/owamp-3.4-10.tar.gz"
  sha256 "059f0ab99b2b3d4addde91a68e6e3641c85ce3ae43b85fe9435841d950ee2fb3"
  license "Apache-2.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "a1fd940dd5c43ba79fe9d5fc1f5b25ebe0b1b3ecbf8eeebabdf0353da09a11cb"
  end

  livecheck do
    url "https://software.internet2.edu/sources/owamp/"
    regex(/href=.*?owamp[._-]v?(\d+(?:\.\d+)+(?:-\d+)?)\.t/i)
  end


  depends_on "i2util"

  # Backport fix for newer Clang
  patch do
    url "https://github.com/perfsonar/owamp/commit/e14c6850d2e82919ca35cc591193220e4ebdc2c5.patch?full_index=1"
    sha256 "bee4e43d43acea5088d03e7822bb5166b27bf8b12b43ada8751bd2cb3cd4a527"
    type :backport
  end

  # Fix to prevent tests hanging under certain circumstances.
  # Provided by Aaron Brown via perfsonar-user mailing list:
  # https://lists.internet2.edu/sympa/arc/perfsonar-user/2014-11/msg00131.html
  patch :DATA

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # fix implicit-function-declaration error
    # reported upstream by email
    inreplace "owamp/capi.c", "#include <assert.h>", "#include <assert.h>\n#include <ctype.h>"

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", "--mandir=#{man}", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"owping", "-h"
  end
end

__END__
diff -ur owamp-3.4/owamp/endpoint.c owamp-3.4.fixed/owamp/endpoint.c
--- owamp-3.4/owamp/endpoint.c	2014-03-21 09:37:42.000000000 -0400
+++ owamp-3.4.fixed/owamp/endpoint.c	2014-11-26 07:50:11.000000000 -0500
@@ -2188,6 +2188,11 @@
         timespecsub((struct timespec*)&wake.it_value,&currtime);

         wake.it_value.tv_usec /= 1000;        /* convert nsec to usec        */
+        while (wake.it_value.tv_usec >= 1000000) {
+            wake.it_value.tv_usec -= 1000000;
+            wake.it_value.tv_sec++;
+        }
+
         tvalclear(&wake.it_interval);

         /*
