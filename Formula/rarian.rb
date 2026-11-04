class Rarian < Formula
  desc "Documentation metadata library"
  homepage "https://rarian.freedesktop.org/"
  url "https://gitlab.freedesktop.org/rarian/rarian/-/releases/0.8.6/downloads/assets/rarian-0.8.6.tar.bz2"
  sha256 "9d4f7873009d2e31b8b1ec762606b12bee5526e1fe75de48e9495382bfef2bea"
  license "GPL-2.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8971105c643c5d1cfe2e2fc2dae7500a634a577073a6ff81ce36f3850c5824a4"
  end

  revision 1

  livecheck do
    url :homepage
    regex(/href=.*?rarian[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "tinyxml2"

  def install
    # Regenerate `configure` to fix `-flat_namespace` bug.
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    seriesid1 = shell_output(bin/"rarian-sk-gen-uuid").strip
    sleep 5
    seriesid2 = shell_output(bin/"rarian-sk-gen-uuid").strip
    assert_match(/^\h+(?:-\h+)+$/, seriesid1)
    assert_match(/^\h+(?:-\h+)+$/, seriesid2)
    refute_equal seriesid1, seriesid2
  end
end
