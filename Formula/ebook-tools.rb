class EbookTools < Formula
  desc "Access and convert several ebook formats"
  homepage "https://sourceforge.net/projects/ebook-tools/"
  url "https://downloads.sourceforge.net/project/ebook-tools/ebook-tools/0.2.2/ebook-tools-0.2.2.tar.gz"
  sha256 "cbc35996e911144fa62925366ad6a6212d6af2588f1e39075954973bbee627ae"
  license "MIT"
  revision 4


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "00182e5fc380b6c75d5ffd7050e5d05e129b5716f89b1c68e57c1a88478338b6"
  end

  depends_on "cmake" => :build
  depends_on "libzip"

  uses_from_macos "libxml2"

  deny_network_access!

  def install
    # Workaround to build with CMake 4
    args = %W[
      -DCMAKE_POLICY_VERSION_MINIMUM=3.5
      -DCMAKE_INSTALL_RPATH=#{rpath}
    ]
    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system bin/"einfo", "-help"

    (testpath/"test_libepub.c").write <<~C
      #include <stdio.h>
      #include "epub_version.h"

      int main() {
          printf("libepub version: %s\\n", LIBEPUB_VERSION_STRING);
          return 0;
      }
    C

    system ENV.cc, "test_libepub.c", "-I#{include}", "-L#{lib}", "-lepub", "-o", "test_libepub"
    system "./test_libepub"
  end
end
