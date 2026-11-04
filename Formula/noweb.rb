class Noweb < Formula
  desc "WEB-like literate-programming tool"
  homepage "https://www.cs.tufts.edu/~nr/noweb/"
  url "https://github.com/nrnrnr/noweb/archive/refs/tags/v2_13.tar.gz"
  sha256 "7b32657128c8e2cb1114cca55023c58fa46789dcffcbe3dabde2c8a82fe57802"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:[._]\d+)+)$/i)
    strategy :git do |tags, regex|
      tags.filter_map { |tag| tag[regex, 1]&.tr("_", ".") }
    end
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c98cb0e17f28cbb7258ba70f01e33f4d1b7b491a37c6573cd1bccdcf1098aeb7"
  end

  depends_on "gnu-sed" => :build
  depends_on "icon"

  # remove pdcached ops, see discussions in https://github.com/nrnrnr/noweb/issues/31
  patch :DATA

  def texpath
    prefix/"tex/generic/noweb"
  end

  def install
    # use gnu-sed on macOS for fixing `illegal byte sequence` error
    ENV.prepend_path "PATH", formula_opt_libexec("gnu-sed")/"gnubin" if OS.mac?

    cd "src" do
      system "bash", "awkname", "awk"
      system "make", "LIBSRC=icon", "ICONC=icont", "CFLAGS=-U_POSIX_C_SOURCE -D_POSIX_C_SOURCE=1"

      bin.mkpath
      lib.mkpath
      man.mkpath
      texpath.mkpath

      system "make", "install", "BIN=#{bin}",
                                "LIB=#{lib}",
                                "MAN=#{man}",
                                "TEXINPUTS=#{texpath}"
      cd "icon" do
        system "make", "install", "BIN=#{bin}",
                                  "LIB=#{lib}",
                                  "MAN=#{man}",
                                  "TEXINPUTS=#{texpath}"
      end
    end
  end

  def caveats
    <<~EOS
      TeX support files are installed in the directory:

        #{texpath}

      You may need to add the directory to TEXINPUTS to run noweb properly.
    EOS
  end

  test do
    (testpath/"test.nw").write <<~NW
      \section{Hello world}

      Today I awoke and decided to write
      some code, so I started to write Hello World in \textsf C.

      <<hello.c>>=
      /*
        <<license>>
      */
      #include <stdio.h>

      int main(int argc, char *argv[]) {
        printf("Hello World!\n");
        return 0;
      }
      @
      \noindent \ldots then I did the same in PHP.

      <<hello.php>>=
      <?php
        /*
        <<license>>
        */
        echo "Hello world!\n";
      ?>
      @
      \section{License}
      Later the same day some lawyer reminded me about licenses.
      So, here it is:

      <<license>>=
      This work is placed in the public domain.
    NW
    assert_match "this file was generated automatically by noweave",
                 pipe_output("#{bin}/htmltoc", shell_output("#{bin}/noweave -filter l2h -index -html test.nw"))
  end
end

__END__
diff --git a/src/icon/Makefile b/src/icon/Makefile
index b8f39ee..db51615 100644
--- a/src/icon/Makefile
+++ b/src/icon/Makefile
@@ -10,11 +10,11 @@ LIBEXECS=totex disambiguate noidx tohtml elide l2h docs2comments \
 	autodefs.promela autodefs.lrtl autodefs.asdl autodefs.mmix xchunks pipedocs
 LIBSPECIAL=autodefs.cee
 BINEXECS=noindex sl2h htmltoc
-EXECS=$(LIBEXECS) $(BINEXECS) $(LIBSPECIAL) pdcached
+EXECS=$(LIBEXECS) $(BINEXECS) $(LIBSPECIAL)
 SRCS=totex.icn disambiguate.icn noidx.icn texdefs.icn icondefs.icn \
 	yaccdefs.icn noindex.icn smldefs.icn tohtml.icn cdefs.icn elide.icn \
 	l2h.icn sl2h.icn pascaldefs.icn promeladefs.icn lrtldefs.icn asdldefs.icn \
-	mmixdefs.icn htmltoc.icn xchunks.icn docs2comments.icn pipedocs.icn pdcached.icn
+	mmixdefs.icn htmltoc.icn xchunks.icn docs2comments.icn pipedocs.icn

 .SUFFIXES: .nw .icn .html .tex .dvi
 .nw.icn:
@@ -141,9 +141,6 @@ elide: elide.icn
 pipedocs: pipedocs.icn
 	$(ICONT) pipedocs.icn

-pdcached: pdcached.icn
-	$(ICONT) pdcached.icn
-
 disambiguate: disambiguate.icn
 	$(ICONT) disambiguate.icn
