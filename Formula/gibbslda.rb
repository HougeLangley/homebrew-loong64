class Gibbslda < Formula
  desc "Library wrapping imlib2's context API"
  homepage "https://gibbslda.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/gibbslda/GibbsLDA%2B%2B/0.2/GibbsLDA%2B%2B-0.2.tar.gz"
  sha256 "4ca7b51bd2f098534f2fdf82c3f861f5d8bf92e29a6b7fbdc50c3c2baeb070ae"
  license "GPL-2.0-or-later"


  # Build fails without including stdlib - https://trac.macports.org/ticket/41915
  # https://sourceforge.net/p/gibbslda/bugs/4/
  # Also fix build failure because of missing #include <stdio.h> on Linux.
  # Linux patch submitted to SourceForge page:
  # https://sourceforge.net/p/gibbslda/bugs/5/
  patch :DATA

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "894cd1e5468ec81164982067e0276cc4b9105bcc4549445b91c3c1c16077da1b"
  end

  def install
    system "make", "clean"
    system "make", "all"
    bin.install "src/lda"
    share.install "docs/GibbsLDA++Manual.pdf"
  end

  test do
    assert_match "Please specify the task you would like to perform", shell_output("#{bin}/lda 2>&1", 1)
  end
end

__END__
diff --git a/src/utils.cpp b/src/utils.cpp
index e2f538b..1df5fb3 100644
--- a/src/utils.cpp
+++ b/src/utils.cpp
@@ -22,6 +22,7 @@
  */

 #include <stdio.h>
+#include <stdlib.h>
 #include <string>
 #include <map>
 #include "strtokenizer.h"
diff --git a/src/lda.cpp b/src/lda.cpp
index 273d469..4b03d85 100644
--- a/src/lda.cpp
+++ b/src/lda.cpp
@@ -21,6 +21,8 @@
  * Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
  */

+#include <stdio.h>
+
 #include "model.h"

 using namespace std;
