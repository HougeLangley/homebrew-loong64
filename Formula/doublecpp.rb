class Doublecpp < Formula
  desc "Double dispatch in C++"
  homepage "https://doublecpp.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/doublecpp/doublecpp/0.6.3/doublecpp-0.6.3.tar.gz"
  sha256 "232f8bf0d73795558f746c2e77f6d7cb54e1066cbc3ea7698c4fba80983423af"
  license "GPL-2.0-or-later"


  # Fix build failure because of missing #include <stdlib.h> on Linux.
  # Patch submitted to author by email.
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "51e8a3dc2767161c99bf70bebff9f5e760fe0d3b1ee79e1320c7d40dd0e37ae8"
  end

  patch :DATA

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}", "dist/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    args = []
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"doublecpp", "--version"
  end
end

__END__
diff --git a/src/branchanalyser.cpp b/src/branchanalyser.cpp
index e6da619..feca23a 100755
--- a/src/branchanalyser.cpp
+++ b/src/branchanalyser.cpp
@@ -9,6 +9,7 @@
  ***************************************************************************/
 
 #include <assert.h>
+#include <stdlib.h>
 
 #include "branchanalyser.h"
 #include "multimethods.h"
diff --git a/src/parambinder.cpp b/src/parambinder.cpp
index b2c77b8..8402221 100755
--- a/src/parambinder.cpp
+++ b/src/parambinder.cpp
@@ -10,6 +10,7 @@
 #include "parambinder.h"
 
 #include <assert.h>
+#include <stdlib.h>
 
 #include "classdecl.h"
 #include "methparams.h"
diff --git a/src/programanalyser.cpp b/src/programanalyser.cpp
index 19e34ba..c69518a 100755
--- a/src/programanalyser.cpp
+++ b/src/programanalyser.cpp
@@ -9,6 +9,8 @@
  ***************************************************************************/
 #include "programanalyser.h"
 
+#include <stdlib.h>
+
 #include "multimethods.h"
 #include "methods.h"
 #include "multimethodtypes.h"
diff --git a/src/sourceanalyser.cpp b/src/sourceanalyser.cpp
index a87fde3..fb6ea5e 100755
--- a/src/sourceanalyser.cpp
+++ b/src/sourceanalyser.cpp
@@ -8,6 +8,8 @@
  *   (at your option) any later version.                                   *
  ***************************************************************************/
 
+#include <stdlib.h>
+
 #include "sourceanalyser.h"
 #include "fileutil.h"
 #include "progelems.hpp"
diff --git a/src/sourcemodifier.cpp b/src/sourcemodifier.cpp
index 5324f6f..84dc15c 100755
--- a/src/sourcemodifier.cpp
+++ b/src/sourcemodifier.cpp
@@ -10,6 +10,7 @@
 
 #include <assert.h>
 #include <iostream> // TODO: remove it when changed ProgElems cons
+#include <stdlib.h>
 
 #include "my_sstream.h"
 
