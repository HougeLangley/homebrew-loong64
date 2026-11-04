class Xlsxio < Formula
  desc "C library for reading values from and writing values to .xlsx files"
  homepage "https://github.com/brechtsanders/xlsxio"
  url "https://github.com/brechtsanders/xlsxio/archive/refs/tags/0.2.37.tar.gz"
  sha256 "b9fcb22e124d178f30d404e5a22ccac594353d71d845035795321cd53d6c4cee"
  license "MIT"
  head "https://github.com/brechtsanders/xlsxio.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e1dc086c89d7357829f1b9d8b229bec936bdce14eb087515574c12759e056a4b"
  end

  depends_on "libzip"
  uses_from_macos "expat"

  def install
    system "make", "install", "PREFIX=#{prefix}", "V=1", "WITH_LIBZIP=1"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdlib.h>
      #include <stdio.h>
      #include <unistd.h>
      #include <xlsxio_read.h>
      #include <xlsxio_write.h>

      int main() {
        xlsxiowriter handle;
        if ((handle = xlsxiowrite_open("myexcel.xlsx", "MySheet")) == NULL) {
          return 1;
        }
        return xlsxiowrite_close(handle);
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-I#{include}", "-lxlsxio_read", "-lxlsxio_write", "-o", "test"
    system "./test"
    assert_path_exists testpath/"myexcel.xlsx", "Failed to create xlsx file"
  end
end
