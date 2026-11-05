class TokyoCabinet < Formula
  desc "Lightweight database library"
  homepage "https://dbmx.net/tokyocabinet/"
  url "https://dbmx.net/tokyocabinet/tokyocabinet-1.4.48.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/t/tokyocabinet/tokyocabinet_1.4.48.orig.tar.gz"
  sha256 "a003f47c39a91e22d76bc4fe68b9b3de0f38851b160bbb1ca07a4f6441de1f90"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "33d872a8b85024725df81d82af356591a46b6188303ac624b946e1876d492f6d"
  end

  livecheck do
    url :homepage
    regex(/href=.*?tokyocabinet[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "pkgconf" => :test

  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdbool.h>
      #include <stdint.h>
      #include <stdio.h>
      #include <stdlib.h>
      #include <tcutil.h>
      #include <tchdb.h>

      int main(void) {
        TCHDB *hdb = tchdbnew();
        if (!tchdbopen(hdb, "test.tch", HDBOWRITER | HDBOCREAT)) return 1;
        tchdbput2(hdb, "foo", "bar");
        char *value = tchdbget2(hdb, "foo");
        printf("%s\\n", value);
        free(value);
        tchdbclose(hdb);
        tchdbdel(hdb);
        return 0;
      }
    C

    pkgconf_flags = shell_output("pkgconf --cflags --libs tokyocabinet").chomp.split
    system ENV.cc, "test.c", "-o", "test", *pkgconf_flags
    assert_equal "bar", shell_output("./test").strip

    system bin/"tchmgr", "create", "cli.tch"
    system bin/"tchmgr", "put", "cli.tch", "hello", "world"
    assert_equal "world", shell_output("#{bin}/tchmgr get cli.tch hello").strip
    assert_match "record number: 1", shell_output("#{bin}/tchmgr inform cli.tch")
  end
end
