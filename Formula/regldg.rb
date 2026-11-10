class Regldg < Formula
  desc "Regular expression grammar language dictionary generator"
  homepage "https://regldg.com/"
  url "https://github.com/PatrickCronin/regldg/releases/download/v1.0.1/regldg-1.0.1.tar.gz"
  sha256 "f5f401c645a94d4c737cefa2bbcb62f23407d25868327902b9c93b501335dc99"
  license "MIT"

  # Workaround for newer Clang
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9c58f120f230566447ede4d5650f52f913b9409f496dbb7d17415cad599210a0"
  end

  patch :DATA

  def install
    flags = "-std=gnu17 -D_GNU_SOURCE -Wno-error=implicit-int -Wno-implicit-int " \
            "-Wno-error=implicit-function-declaration -Wno-error=int-conversion " \
            "-Wno-error=incompatible-pointer-types"
    inreplace "Makefile" do |s|
      s.sub! "COMPILE=cc ", "COMPILE=#{ENV.cc} #{flags} "
      s.sub! "LINK=gcc ", "LINK=#{ENV.cc} "
    end
    # Temporary Homebrew-specific work around for linker flag ordering problem in Ubuntu 16.04.
    # Remove after migration to 18.04.
    inreplace "Makefile", "-o regldg", "-o regldg -lm" unless OS.mac?
    system "make"
    bin.install "regldg"
  end

  test do
    system bin/"regldg", "test"
  end
end

__END__
diff --git a/Makefile b/Makefile
index 5e18193..6dee9ae 100755
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # Makefile
 # Project building instructions.
 
-COMPILE=cc -O3 -Wall -g -c
+COMPILE=cc -O3 -Wall -Wno-int-conversion -g -c
 LINK=gcc -O3 -Wall -g -lm
 
 all: alt.o altlist.o build_structs.o char_set.o data.o debug.o \
