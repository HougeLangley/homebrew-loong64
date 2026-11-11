class Valgrind < Formula
  desc "Dynamic analysis tools (memory, debug, profiling) with the LoongArch64 port"
  homepage "https://github.com/CSharperMantle/valgrind-loongarch64"
  # Upstream valgrind has no LoongArch backend; this maintained port
  # (3.28.0-based) adds it. Pin the exact commit for reproducibility.
  url "https://github.com/CSharperMantle/valgrind-loongarch64.git",
      revision: "71d88d33c8bb5c319950e662e249181a08f115be"
  version "3.28.0"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "125bbc96e0a0a3fed3406f1dd6718f3359411d7da2d88a62c814de2e9756950d"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-only64bit
      --without-mpicc
    ]

    system "./autogen.sh"
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "usage", shell_output("#{bin}/valgrind --help")

    # Real memcheck round-trip: clean program exits 0 under memcheck.
    (testpath/"clean.c").write <<~C
      #include <stdlib.h>
      int main(void) { return 0; }
    C
    system ENV.cc, "clean.c", "-o", "clean"
    system bin/"valgrind", "--error-exitcode=9", "./clean"

    # A deliberate definite leak must be reported (exit 9).
    (testpath/"leaky.c").write <<~C
      #include <stdlib.h>
      int main(void) { char *p = malloc(64); p[0] = 1; (void)p; return 0; }
    C
    system ENV.cc, "leaky.c", "-o", "leaky"
    output = shell_output("#{bin}/valgrind --leak-check=full --errors-for-leak-kinds=definite --error-exitcode=9 ./leaky 2>&1", 9)
    assert_match "definitely lost: 64 bytes", output
  end
end
