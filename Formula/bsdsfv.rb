class Bsdsfv < Formula
  desc "SFV utility tools"
  homepage "https://bsdsfv.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/bsdsfv/bsdsfv/1.18/bsdsfv-1.18.tar.gz"
  sha256 "577245da123d1ea95266c1628e66a6cf87b8046e1a902ddd408671baecf88495"
  license "BSD-3-Clause"


  # bug report:
  # https://sourceforge.net/p/bsdsfv/bugs/1/
  # Patch from MacPorts, plus storing `getopt()` in an `int` since `char` is unsigned on arm64 Linux
  patch :DATA

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d10dcbc3612c1160e55b15b6d496aa714bf35656b33a548c7af78af7a533978e"
  end

  def install
    bin.mkpath

    inreplace "Makefile" do |s|
      s.change_make_var! "INSTALL_PREFIX", prefix
      s.change_make_var! "INDENT", "indent"
      s.gsub! "	${INSTALL_PROGRAM} bsdsfv ${INSTALL_PREFIX}/bin", "	${INSTALL_PROGRAM} bsdsfv #{bin}/"
    end

    system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"test.rar").write "Homebrew"
    system bin/"bsdsfv", "-c", "test.sfv", "test.rar"
    assert_match "test.rar 17AD264F", (testpath/"test.sfv").read
    assert_match "1 OK - 0 bad - 0 missing", shell_output("#{bin}/bsdsfv -T test.sfv")
  end
end

__END__
--- a/bsdsfv.c	2012-09-25 07:31:03.000000000 -0500
+++ b/bsdsfv.c	2012-09-25 07:31:08.000000000 -0500
@@ -44,5 +44,5 @@
 typedef struct sfvtable {
	char filename[FNAMELEN];
-	int crc;
+	unsigned int crc;
	int found;
 } SFVTABLE;
@@ -321,7 +321,7 @@
 	time_t curtime;
 	struct tm zeit;
 	char mytime[80];
-	char ch;
+	int ch;
 
 // output program name & version number
 	printf("%s\n", BSDSFV_VERSION);
