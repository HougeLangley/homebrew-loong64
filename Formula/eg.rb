class Eg < Formula
  desc "Expert Guide. Norton Guide Reader For GNU/Linux"
  homepage "https://github.com/davep/eg"
  url "https://github.com/davep/eg/archive/refs/tags/v1.02.tar.gz"
  sha256 "6b73fff51b5cf82e94cdd60f295a8f80e7bbb059891d4c75d5b1a6f0c5cc7003"
  license "GPL-2.0-or-later"
  head "https://github.com/davep/eg.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2eafb24268bd6822cdfc9998d350327adc8a93c4a6447e1e9ce3dccae47dc6da"
  end

  depends_on "s-lang"

  conflicts_with "eg-examples", because: "both install `eg` binaries"

  # Fix error: parameter 'iRefresh' was not declared, defaults to 'int';
  # ISO C99 and later do not support implicit int [-Wimplicit-int]
  patch :DATA

  def install
    inreplace "eglib.c", "/usr/share/", "#{etc}/"
    bin.mkpath
    man1.mkpath
    system "make"
    system "make", "install", "BINDIR=#{bin}", "MANDIR=#{man}", "NGDIR=#{etc}/norton-guides"
  end

  test do
    # It will return a non-zero exit code when called with any option
    # except a filename, but will return success if the file doesn't
    # exist, without popping into the UI - we're exploiting this here.
    ENV["TERM"] = "xterm"
    system bin/"eg", "not_here.ng"
  end
end

__END__
diff --git a/egscreen.c b/egscreen.c
index d3c7e66..31bbca3 100644
--- a/egscreen.c
+++ b/egscreen.c
@@ -211,7 +211,7 @@ void DisplayMessage( char *pszMsg, int iRefresh )
 /*
  */

-void ShowStdMsg( iRefresh )
+void ShowStdMsg( int iRefresh )
 {
     char *pszMsg = (char *) egmalloc( strlen( CurrentGuide( NULL ) ) +
                                       strlen( EG_VERSION ) + 7 );
