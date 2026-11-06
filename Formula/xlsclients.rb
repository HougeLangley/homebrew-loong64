class Xlsclients < Formula
  desc "List client applications running on a display"
  homepage "https://gitlab.freedesktop.org/xorg/app/xlsclients"
  url "https://xorg.freedesktop.org/archive/individual/app/xlsclients-1.1.6.tar.xz"
  sha256 "909810a3fdbd01d84747907f2c0cc32ee732e77afc88cb310abb9d155b2a0807"
  license "MIT"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "16eb9ac188e7424b6e22cb6da241b2874d708c8f2a6c775d815887d820bd03d5"
  end

  depends_on "pkgconf" => :build
  depends_on "libxcb"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/xlsclients -display :100 2>&1", 1)
    assert_match "xlsclients:  unable to open display", output
  end
end
