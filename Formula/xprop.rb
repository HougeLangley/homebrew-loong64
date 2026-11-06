class Xprop < Formula
  desc "Property displayer for X"
  homepage "https://gitlab.freedesktop.org/xorg/app/xprop"
  url "https://xorg.freedesktop.org/archive/individual/app/xprop-1.2.8.tar.xz"
  sha256 "d689e2adb7ef7b439f6469b51cda8a7daefc83243854c2a3b8f84d0f029d67ee"
  license "MIT-open-group"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "11e3c23c4af42726900ab2e26108abf7960d56c6d8ee5697b44870cc5a89fab1"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/xprop -display :100 2>&1", 1)
    assert_match "xprop:  unable to open display", output
  end
end
