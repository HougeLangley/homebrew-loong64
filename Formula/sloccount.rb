class Sloccount < Formula
  desc "Count lines of code in many languages"
  homepage "https://dwheeler.com/sloccount/"
  url "https://dwheeler.com/sloccount/sloccount-2.26.tar.gz"
  sha256 "fa7fa2bbf2f627dd2d0fdb958bd8ec4527231254c120a8b4322405d8a4e3d12b"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fb30294947044067855c05c86ffc89c88d37225ce49207a2d8c4d4ebe2fafc51"
  end

  livecheck do
    url :homepage
    regex(/href=.*?sloccount[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  uses_from_macos "flex" => :build

  patch do
    url "https://sourceforge.net/p/sloccount/patches/21/attachment/sloccount-suppress-exec-warnings.patch"
    sha256 "4e68a7d9c61d62d4b045d1e5d099c6853456d15f874d659f3ab473e7fc40d565"
    type :unofficial
    resolves "https://sourceforge.net/p/sloccount/patches/21"
  end

  patch :DATA


  def install
    rm "makefile.orig" # Delete makefile.orig or patch falls over
    bin.mkpath # Create the install dir or install falls over
    system "make", "install", "PREFIX=#{prefix}"
    (bin/"erlang_count").write "#!/bin/sh\ngeneric_count '%' $@"
  end

  test do
    system bin/"sloccount", "--version"
  end
end

__END__
diff --git a/break_filelist b/break_filelist
index ad2de47..ff854e0 100755
--- a/break_filelist
+++ b/break_filelist
@@ -205,6 +205,7 @@ $noisy = 0;            # Set to 1 if you want noisy reports.
   "hs" => "haskell", "lhs" => "haskell",
    # ???: .pco is Oracle Cobol
   "jsp" => "jsp",  # Java server pages
+  "erl" => "erlang",
 );
