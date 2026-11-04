class Libansilove < Formula
  desc "Library for converting ANSI, ASCII, and other formats to PNG"
  homepage "https://www.ansilove.org"
  url "https://github.com/ansilove/libansilove/releases/download/1.4.3/libansilove-1.4.3.tar.gz"
  sha256 "f1d6f75e01aa44eaa79f8b63e9bb2c9d0f4d5d55b234e9abaf790314cccbfc18"
  license "BSD-2-Clause"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "55858aef55f455d32ba06677affc87d5ec935fe5a00c9faab60f0e9f4c919721"
  end

  depends_on "cmake" => :build
  depends_on "gd"

  deny_network_access!

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <ansilove.h>

      int main(int argc, char *argv[])
      {
        struct ansilove_ctx ctx;
        struct ansilove_options options;

        ansilove_init(&ctx, &options);
        ansilove_loadfile(&ctx, "example.c");
        ansilove_ansi(&ctx, &options);
        ansilove_savefile(&ctx, "example.png");
        ansilove_clean(&ctx);
      }
    C

    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lansilove", "-o", "test"
    system "./test"
  end
end
