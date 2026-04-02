class Tree < Formula
  desc "Display directories as trees (with optional color/HTML output)"
  homepage "http://mama.indstate.edu/users/ice/tree/"
  url "https://deb.debian.org/debian/pool/main/t/tree/tree_2.1.3.orig.tar.gz"
  sha256 "f5f94133f920bb1e7a7fcb7b389dd1d4c0f09e1e8fce479b86c5a26e58dd8c6a"
  license "GPL-2.0-or-later"

  def install
    ENV.append "CFLAGS", "-fomit-frame-pointer"
    objs = "tree.o unix.o html.o xml.o json.o hash.o color.o file.o strverscmp.o"
    
    system "make", "prefix=#{prefix}", "MANDIR=#{man1}", "CC=#{ENV.cc}", "CFLAGS=#{ENV.cflags}", "OBJS=#{objs}"
    bin.install "tree"
    man1.install "tree.1"
  end

  test do
    system bin/"tree", "--version"
  end
end
