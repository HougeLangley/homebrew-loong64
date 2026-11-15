class Liboil < Formula
  desc "C library of simple functions optimized for various CPUs"
  homepage "https://wiki.freedesktop.org/liboil/"
  url "https://liboil.freedesktop.org/download/liboil-0.3.17.tar.gz"
  sha256 "105f02079b0b50034c759db34b473ecb5704ffa20a5486b60a8b7698128bfc69"
  # Only liboil/ref/mt19937ar.c is BSD-3-Clause while rest is BSD-2-Clause.
  # The license for liboil/motovec/* is excluded as it is only used on PowerPC.
  license all_of: ["BSD-2-Clause", "BSD-3-Clause"]


  # https://lists.freedesktop.org/archives/liboil/2010-February/000251.html
  # https://gitlab.freedesktop.org/archived-projects/liboil
  deprecate! date: "2026-08-14", because: :unmaintained, replacement_formula: "orc"
  disable! date: "2027-02-14", because: :unmaintained, replacement_formula: "orc"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "416029a557f2a4fc6824ecd3f697bb715b82498b1abf9da7a601f02b2c38a9de"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gtk-doc" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build

  def install
    ENV.append "CFLAGS", "-fheinous-gnu-extensions" if ENV.compiler == :clang

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #include <liboil/liboil.h>
      int main(int argc, char** argv) {
        oil_init();
        return 0;
      }
    C

    flags = ["-I#{include}/liboil-0.3", "-L#{lib}", "-loil-0.3"] + ENV.cflags.to_s.split
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
