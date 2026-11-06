class Lightning < Formula
  desc "Generates assembly language code at run-time"
  homepage "https://www.gnu.org/software/lightning/"
  url "https://ftpmirror.gnu.org/lightning/lightning-2.2.3.tar.gz"
  mirror "https://ftp.gnu.org/gnu/lightning/lightning-2.2.3.tar.gz"
  sha256 "c045c7a33a00affbfeb11066fa502c03992e474a62ba95977aad06dbc14c6829"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8da1003dfa5695c02fd2777dbf82012fb9cc7be4a6550610012e9df9455dd0a0"
  end

  revision 1


  depends_on "binutils" => :build # for libopcodes.a

  # upstream patch for fixing `Correct wrong ifdef causing missing mprotect call if NDEBUG is not defined`
  # Using local patch file as repository url can 502-error and server's cgit version is included in patch
  # https://cgit.git.savannah.gnu.org/cgit/lightning.git/patch/?id=bfd695a94668861a9447b29d2666f8b9c5dcd5bf
  patch do
    file "Patches/lightning/bfd695a94668861a9447b29d2666f8b9c5dcd5bf.patch"
    type :backport
  end

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    # from https://www.gnu.org/software/lightning/manual/lightning.html#incr
    (testpath/"test.c").write <<~C
      #include <stdio.h>
      #include <lightning.h>
      static jit_state_t *_jit;
      typedef int (*pifi)(int);
      int main(int argc, char *argv[]) {
        jit_node_t  *in;
        pifi incr;
        init_jit(argv[0]);
        _jit = jit_new_state();
        jit_prolog();
        in = jit_arg();
        jit_getarg(JIT_R0, in);
        jit_addi(JIT_R0, JIT_R0, 1);
        jit_retr(JIT_R0);
        incr = jit_emit();
        jit_clear_state();
        printf("%d + 1 = %d\\n", 5, incr(5));
        jit_destroy_state();
        finish_jit();
        return 0;
      }
    C
    system ENV.cc, "test.c", "-L#{lib}", "-llightning", "-o", "test"
    system "./test"
  end
end
