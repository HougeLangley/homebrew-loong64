class Libgfshare < Formula
  desc "Library for sharing secrets"
  homepage "https://github.com/kinnison/libgfshare"
  url "https://github.com/kinnison/libgfshare/archive/refs/tags/2.0.0.tar.gz"
  sha256 "91d7ea7f3e5ddb3854a38827a3f6ea7c597db03067735dc953bd31c5b90f9930"
  license "MIT"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1c9246459c5cb4ab4df5c8a8982b518679b6d35d815b72b0de6958f91799980a"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--disable-linker-optimisations",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    touch "test.in"
    system bin/"gfsplit", "test.in"
    system bin/"gfcombine test.in.*"
  end
end
