class Xwininfo < Formula
  desc "Print information about windows on an X server"
  homepage "https://gitlab.freedesktop.org/xorg/app/xwininfo"
  url "https://xorg.freedesktop.org/archive/individual/app/xwininfo-1.1.7.tar.xz"
  sha256 "bee14d594cc86cc59aae1015c1b452a71bf60c304131e2716ca1cf0df733b4ac"
  license "MIT"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "b2ef992da79c3e27c42704845d1b45e9e31a6eb3fbba5c892fb30a77beeb603b"
  end

  depends_on "pkgconf" => :build
  depends_on "libx11"
  depends_on "libxcb"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/xwininfo -display :100 2>&1", 1)
    assert_match "xwininfo: error: unable to open display", output
  end
end
