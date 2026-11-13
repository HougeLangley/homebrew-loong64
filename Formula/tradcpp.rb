class Tradcpp < Formula
  desc "K&R-style C preprocessor"
  homepage "https://www.netbsd.org/~dholland/tradcpp/"
  url "https://cdn.netbsd.org/pub/NetBSD/misc/dholland/tradcpp-0.5.3.tar.gz"
  sha256 "e17b9f42cf74b360d5691bc59fb53f37e41581c45b75fcd64bb965e5e2fe4c5e"
  license "BSD-2-Clause"

  livecheck do
    url :homepage
    regex(/href=.*?tradcpp[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "afb4fb301105d05035c64be63f001e41a2bc37bb330fdcfe85c3aac3df152ae8"
  end

  depends_on "bmake" => :build

  def install
    bmake_args = %W[
      prefix=#{prefix}
      MK_INSTALL_AS_USER=yes
      MANDIR=#{man}
    ]

    system "bmake", "CFLAGS=-std=gnu17 -g"
    system "bmake", *bmake_args, "install"
  end

  test do
    (testpath/"test.c").write <<~C
      #define FOO bar
      FOO
    C
    assert_match "bar", shell_output("#{bin}/tradcpp ./test.c")
  end
end
