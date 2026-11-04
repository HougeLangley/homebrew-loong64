class Hfstospell < Formula
  desc "Helsinki Finite-State Technology ospell"
  homepage "https://hfst.github.io/"
  url "https://github.com/hfst/hfst-ospell/releases/download/v0.5.4/hfst-ospell-0.5.4.tar.bz2"
  sha256 "ab644c802f813a06a406656c3a873d31f6a999e13cafc9df68b03e76714eae0e"
  license "Apache-2.0"
  revision 5

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c4b5c4643e2357b3e62da188262f61f01094214bbe39a873f36b6620673491c6"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "icu4c@79"
  depends_on "libarchive"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules", "--without-libxmlpp", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"hfst-ospell", "--version"
  end
end
