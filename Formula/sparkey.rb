class Sparkey < Formula
  desc "Constant key-value store, best for frequent read/infrequent write uses"
  homepage "https://github.com/spotify/sparkey/"
  url "https://github.com/spotify/sparkey/archive/refs/tags/sparkey-1.0.0.tar.gz"
  sha256 "d607fb816d71d97badce6301dd56e2538ef2badb6530c0a564b1092788f8f774"
  license "Apache-2.0"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "5afac967cae09c868c423921e097d6b141c0de2f55cc6499ab7d513782c5589a"
  end

  revision 1



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "snappy"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
    mv bin/"bench", bin/"sparkey_bench"
  end

  test do
    system bin/"sparkey", "createlog", "-c", "snappy", "test.spl"
    assert_empty pipe_output("#{bin}/sparkey appendlog -d . test.spl 2>&1", "foo.bar")

    system bin/"sparkey", "writehash", "test.spl"
    assert_empty shell_output("#{bin}/sparkey get test.spi foo", 2)
  end
end
