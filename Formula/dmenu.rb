class Dmenu < Formula
  desc "Dynamic menu for X11"
  homepage "https://tools.suckless.org/dmenu/"
  url "https://dl.suckless.org/tools/dmenu-5.4.tar.gz"
  sha256 "8fbace2a0847aa80fe861066b118252dcc7b4ca0a0a8f3a93af02da8fb6cd453"
  license "MIT"
  head "https://git.suckless.org/dmenu/", using: :git, branch: "master"

  livecheck do
    url "https://dl.suckless.org/tools/"
    regex(/href=.*?dmenu[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9f9834a934cacd1dbb151f0cbae367e66285554c4f2bab94fe9cb61386ff1449"
  end

  depends_on "fontconfig"
  depends_on "libx11"
  depends_on "libxft"
  depends_on "libxinerama"

  def install
    system "make", "FREETYPEINC=#{HOMEBREW_PREFIX}/include/freetype2", "PREFIX=#{prefix}", "install"
  end

  test do
    expected = ENV["DISPLAY"].present? ? "warning: no locale support" : "cannot open display"
    assert_match expected, shell_output("#{bin}/dmenu 2>&1", 1)
  end
end
