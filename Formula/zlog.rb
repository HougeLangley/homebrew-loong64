class Zlog < Formula
  desc "High-performance C logging library"
  homepage "https://github.com/HardySimpson/zlog"
  url "https://github.com/HardySimpson/zlog/archive/refs/tags/1.2.20.tar.gz"
  sha256 "432723ccd9a5b07ec1e4b8cc985d9011d768633b1e4c4facfc0e3e9a7ad5fcf7"
  license "Apache-2.0"


  on_macos do
    depends_on "make" => :build
  end

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d7a33896a421c8ee9d9ae583236a52a7c5b02f194a08b95f9f2228f1fc17c7bd"
  end

  def install
    make = OS.mac? ? "gmake" : "make"

    system make, "PREFIX=#{prefix}"
    system make, "PREFIX=#{prefix}", "install"
  end

  test do
    (testpath/"zlog.conf").write <<~INI
      [formats]
      simple = "%m%n"
      [rules]
      my_cat.DEBUG    >stdout; simple
    INI
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <zlog.h>
      int main() {
        int rc;
        zlog_category_t *c;

        rc = zlog_init("zlog.conf");
        if (rc) {
          printf("init failed!");
          return -1;
        }

        c = zlog_get_category("my_cat");
        if (!c) {
          printf("get cat failed!");
          zlog_fini();
          return -2;
        }

        zlog_info(c, "hello, zlog!");
        zlog_fini();

        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-lzlog", "-pthread", "-o", "test"
    assert_equal "hello, zlog!\n", shell_output("./test")
  end
end
