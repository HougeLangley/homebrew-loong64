class Zsh < Formula
  desc "UNIX shell (command interpreter)"
  homepage "https://www.zsh.org/"
  url "https://sourceforge.net/projects/zsh/files/zsh/5.9/zsh-5.9.tar.xz/download"
  mirror "https://ftp.osuosl.org/pub/blfs/conglomeration/zsh/zsh-5.9.tar.xz"
  sha256 "9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5"
  license "MIT-Modern-Variant"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "ncurses"
  depends_on "pcre2"

  # Fix for ncurses 6.6+ termcap type conflict
  # Modifies configure.ac to use correct type for boolcodes detection
  patch :DATA

  def install
    cpu = Hardware::CPU.loongarch? ? "loongarch64" : Hardware.oldest_cpu
    
    # Regenerate configure script after patch
    system "autoreconf", "-vfi"
    
    system "./configure", "--prefix=#{prefix}",
                          "--build=#{cpu}-unknown-linux-gnu",
                          "--enable-cap",
                          "--enable-pcre",
                          "--enable-zsh-secure-free",
                          "--enable-function-subdirs",
                          "--disable-silent-rules"
    
    system "make"
    system "make", "install"
    
    # Install functions and help files
    (share/"zsh/functions").install Dir["functions/*"]
  end

  test do
    system "#{bin}/zsh", "--version"
  end
end

__END__
diff --git a/configure.ac b/configure.ac
index 1234567..abcdefg 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1764,7 +1764,7 @@ if test x$zsh_cv_path_term_header != xnone; then
   fi
 
   AC_MSG_CHECKING(if boolcodes is available)
-  AC_LINK_IFELSE([AC_LANG_PROGRAM([[$term_includes]], [[char **test = boolcodes; puts(*test);]])],[AC_DEFINE(HAVE_BOOLCODES) boolcodes=yes],[boolcodes=no])
+  AC_LINK_IFELSE([AC_LANG_PROGRAM([[$term_includes]], [[const char * const *test = boolcodes; puts(*test);]])],[AC_DEFINE(HAVE_BOOLCODES) boolcodes=yes],[boolcodes=no])
   AC_MSG_RESULT($boolcodes)
 
   AC_MSG_CHECKING(if numcodes is available)
