class Sollya < Formula
  desc "Library for safe floating-point code development"
  homepage "https://www.sollya.org/"
  url "https://www.sollya.org/releases/sollya-8.0/sollya-8.0.tar.gz"
  sha256 "58d734f9a2fc8e6733c11f96d2df9ab25bef24d71c401230e29f0a1339a81192"
  license "CECILL-C"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5eadfe3fe8865db52f8177ced1912045baa8cbd897ff4f1d9197fec95b3e0e51"
  end

  revision 3

  livecheck do
    url "https://www.sollya.org/download.php"
    regex(/href=.*?sollya[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  depends_on "automake" => :build
  depends_on "pkgconf" => :test
  depends_on "fplll"
  depends_on "gmp"
  depends_on "mpfi"
  depends_on "mpfr"

  uses_from_macos "libxml2"

  def install
    # C23 no longer treats an empty parameter list as an unspecified prototype.
    inreplace "execute.h", "extern int miniyyparse();",
              "extern int miniyyparse(void *myScanner);"
    inreplace "execute.c" do |s|
      s.gsub!("extern void initSignalHandlerCounted();",
              "extern void initSignalHandlerCounted(int nointeract);")
      s.gsub!("extern void blockSignalsCounted();",
              "extern void blockSignalsCounted(int nointeract);")
      s.gsub!("initSignalHandlerCounted();", "initSignalHandlerCounted(0);")
      s.gsub!("blockSignalsCounted();", "blockSignalsCounted(0);")
    end
    inreplace "signalhandling.h", "void blockSignalsCounted();",
              "void blockSignalsCounted(int nointeract);"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"cos.sollya").write <<~EOF
      write(taylor(2*cos(x),1,0)) > "two.txt";
      quit;
    EOF
    system bin/"sollya", "cos.sollya"
    assert_equal "2", (testpath/"two.txt").read

    (testpath/"test.c").write <<~C
      #include <sollya.h>

      int main(void) {
        sollya_obj_t f;
        sollya_lib_init();
        f = sollya_lib_pi();
        sollya_lib_printf("%b", f);
        sollya_lib_clear_obj(f);
        sollya_lib_close();
        return 0;
      }
    C
    pkgconf_flags = shell_output("pkgconf --cflags --libs gmp mpfr fplll").chomp.split
    system ENV.cc, "test.c", *pkgconf_flags, "-I#{include}", "-L#{lib}", "-lsollya", "-o", "test"
    assert_equal "pi", shell_output("./test")
  end
end
