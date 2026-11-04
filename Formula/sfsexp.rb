class Sfsexp < Formula
  desc "Small Fast S-Expression Library"
  homepage "https://github.com/mjsottile/sfsexp"
  url "https://github.com/mjsottile/sfsexp/releases/download/v1.4.1/sfsexp-1.4.1.tar.gz"
  sha256 "15e9a18bb0d5c3c5093444a9003471c2d25ab611b4219ef1064f598668723681"
  license "LGPL-2.1-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "c1417afd18db9aed27ddb872b5427355e9ef9e877c90b364e77de6e4608657ea"
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  uses_from_macos "m4" => :build

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~'EOS'
      #include <stdio.h>
      #include <string.h>
      #include <sexp.h>
      #include <sexp_ops.h>

      int main() {
        const char *test_expr = "(test 123 (nested 456))";
        size_t len = strlen(test_expr);

        sexp_t *sx = parse_sexp((char *)test_expr, len);

        if (sx == NULL) {
          fprintf(stderr, "Failed to parse S-expression\n");
          return 1;
        }

        if (sx->ty != SEXP_LIST) {
          fprintf(stderr, "Expected list type\n");
          destroy_sexp(sx);
          return 1;
        }

        // Success if we got here
        destroy_sexp(sx);
        printf("S-expression test passed\n");
        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}/sfsexp", "-L#{lib}", "-o", "test", "test.c", "-lsexp"
    system "./test"
  end
end
