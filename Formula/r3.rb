class R3 < Formula
  desc "High-performance URL router library"
  homepage "https://c9s.github.io/r3/bench.html"
  license "MIT"
  head "https://github.com/c9s/r3.git", branch: "master"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "e99bafb3a617acc4cc310f42fd5377db7f81af1abb7a01651d5deea2fe277c92"
  end

  stable do
    url "https://github.com/c9s/r3/archive/refs/tags/1.3.4.tar.gz"
    sha256 "db1fb91e51646e523e78b458643c0250231a2640488d5781109f95bd77c5eb82"

    # Backport PCRE2 support (rebased subset of upstream commit c105117)
    patch do
      file "Patches/r3/1.3.4.patch"
      type :backport
      resolves "https://github.com/c9s/r3/pull/153"
    end
  end

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "jemalloc"
  depends_on "pcre2"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules",
                          "--with-malloc=jemalloc",
                          *std_configure_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include "r3.h"
      int main() {
          node * n = r3_tree_create(1);
          r3_tree_free(n);
          return 0;
      }
    CPP
    system ENV.cc, "test.cpp", "-o", "test",
                  "-L#{lib}", "-lr3", "-I#{include}/r3"
    system "./test"
  end
end
