class Libptytty < Formula
  desc "Library for OS-independent pseudo-TTY management"
  homepage "https://software.schmorp.de/pkg/libptytty.html"
  url "https://dist.schmorp.de/libptytty/libptytty-2.0.tar.gz"
  sha256 "8033ed3aadf28759660d4f11f2d7b030acf2a6890cb0f7926fb0cfa6739d31f7"
  license "GPL-2.0-or-later"

  livecheck do
    url "https://dist.schmorp.de/libptytty/"
    regex(/href=.*?libptytty[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9bf0af6d0c9383531f8f89591299ef3a5dd79ae80478684b4d0c00a62a9c12a4"
  end

  depends_on "cmake" => :build

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <libptytty.h>

      int main(void) {
        ptytty_init();
        PTYTTY p = ptytty_create();
        if (!p || !ptytty_get(p)) return 1;
        printf("ok\\n");
        ptytty_delete(p);
        return 0;
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lptytty", "-o", "test"
    system "./test"
  end
end
