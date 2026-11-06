class Id3lib < Formula
  desc "ID3 tag manipulation"
  homepage "https://id3lib.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/id3lib/id3lib/3.8.3/id3lib-3.8.3.tar.gz"
  sha256 "2749cc3c0cd7280b299518b1ddf5a5bcfe2d1100614519b68702230e26c7d079"
  license "LGPL-2.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "164bc67292f10b976e6d835aa5c7687df91f6b36bd7eff5a4a924f25daad9231"
  end

  revision 1
  compatibility_version 1


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  on_linux do
    depends_on "zlib-ng-compat"
  end

  patch do
    file "Patches/id3lib/id3lib-main.patch"
  end

  patch do
    file "Patches/id3lib/id3lib-vbr-overflow.patch"
  end

  patch do
    file "Patches/id3lib/no-iomanip.h.patch"
  end

  patch do
    file "Patches/id3lib/automake.patch"
  end

  patch do
    file "Patches/id3lib/boolcheck.patch"
  end

  # fixes Unicode display problem in easytag: see Homebrew/homebrew-x11#123
  patch do
    file "Patches/id3lib/patch_id3lib_3.8.3_UTF16_writing_bug.diff"
  end

  patch :DATA

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <cstdio>
      #include <id3/tag.h>
      #include <id3/misc_support.h>

      int main() {
        {
          ID3_Tag tag;
          tag.Link("test.mp3");
          ID3_AddTitle(&tag, "Homebrew Song", true);
          ID3_AddArtist(&tag, "Homebrew Artist", true);
          tag.Update(ID3TT_ID3V2);
        }
        ID3_Tag tag("test.mp3");
        char* title = ID3_GetTitle(&tag);
        char* artist = ID3_GetArtist(&tag);
        std::printf("%s by %s\\n", title, artist);
        ID3_FreeString(title);
        ID3_FreeString(artist);
        return 0;
      }
    CPP
    (testpath/"test.mp3").write "dummy audio data"
    system ENV.cxx, "test.cpp", "-I#{include}", "-L#{lib}", "-lid3", "-lz", "-o", "test"
    assert_equal "Homebrew Song by Homebrew Artist", shell_output("./test").strip
  end
end

__END__
--- a/include/id3/id3lib_strings.h
+++ b/include/id3/id3lib_strings.h
@@ -30,6 +30,7 @@
 #define _ID3LIB_STRINGS_H_

 #include <string>
+#include <cstring>

 #if (defined(__GNUC__) && (__GNUC__ >= 3) || (defined(_MSC_VER) && _MSC_VER > 1000))
 namespace std
--- a/include/id3/writers.h
+++ b/include/id3/writers.h
@@ -30,7 +30,7 @@

 #include "id3/writer.h"
 #include "id3/id3lib_streams.h"
-//#include <string.h>
+#include <cstring>

 class ID3_CPP_EXPORT ID3_OStreamWriter : public ID3_Writer
 {
