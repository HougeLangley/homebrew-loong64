class Judy < Formula
  desc "State-of-the-art C library that implements a sparse dynamic array"
  homepage "https://judy.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/judy/judy/Judy-1.0.5/Judy-1.0.5.tar.gz"
  sha256 "d2704089f85fdb6f2cd7e77be21170ced4b4375c03ef1ad4cf1075bd414a63eb"
  license "LGPL-2.1-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2ee8e7556b0720344f0a8623ea7f02585829ca8ef2075d8f0a4039da8f3316d7"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    # Regenrate configure script as it is too old for libtool patch
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    ENV.deparallelize
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <Judy.h>

      int main() {
        Pvoid_t judyArray = (Pvoid_t) NULL;
        Word_t index;
        PWord_t pValue;

        for (index = 0; index < 10; index++) {
          JLI(pValue, judyArray, index);
          *pValue = index * index;
        }

        for (index = 0; index < 10; index++) {
          JLG(pValue, judyArray, index);
          if (pValue != NULL) {
            printf("Square of %lu is %lu\\n", index, *pValue);
          } else {
            printf("Value not found for index %lu\\n", index);
          }
        }

        Word_t byteCount = 0;
        JLFA(byteCount, judyArray);
        printf("Freed %lu bytes\\n", byteCount);

        return 0;
      }
    C

    system ENV.cc, "test.c", "-L#{lib}", "-lJudy", "-o", "test"
    system "./test"
  end
end
