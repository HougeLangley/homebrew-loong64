class Libnxml < Formula
  desc "C library for parsing, writing, and creating XML files"
  homepage "https://github.com/bakulf/libnxml"
  url "https://github.com/bakulf/libnxml/archive/refs/tags/0.18.5.tar.gz"
  sha256 "263d6424db3cd5f17a9f6300594548e82449ed22af59e9e5534646fa0dabd6a7"
  license "LGPL-2.1-or-later"
  head "https://github.com/bakulf/libnxml.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5bac91334eb6eb5b936f6b2e425b0ec9f3dac60823faeaedfb806cbf9eaa942f"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => [:build, :test]

  uses_from_macos "curl"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.xml").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <root>Hello world!<child>This is a child element.</child></root>
    XML

    (testpath/"test.c").write <<~C
      #include <nxml.h>

      int main(int argc, char **argv) {
        nxml_t *data;
        nxml_error_t err;
        nxml_data_t *element;
        char *buffer;

        data = nxmle_new_data_from_file("test.xml", &err);
        if (err != NXML_OK) {
          printf("Unable to read test.xml file");
          exit(1);
        }

        element = nxmle_root_element(data, &err);
        if (err != NXML_OK) {
          printf("Unable to get root element");
          exit(1);
        }

        buffer = nxmle_get_string(element, &err);
        if (err != NXML_OK) {
          printf("Unable to get string from root element");
          exit(1);
        }

        printf("%s: %s\\n", element->value, buffer);

        free(buffer);
        nxmle_free(data);
        exit(0);
      }
    C

    flags = shell_output("pkgconf --cflags --libs nxml").chomp.split
    system ENV.cc, "test.c", "-o", "test", *flags
    assert_equal "root: Hello world!\n", shell_output("./test")
  end
end
