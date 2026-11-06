class Nudoku < Formula
  desc "Ncurses based sudoku game"
  homepage "https://jubalh.github.io/nudoku/"
  url "https://github.com/jubalh/nudoku/archive/refs/tags/8.0.1.tar.gz"
  sha256 "4e8a35950b7b7ce1e49f9457a8aceffbd21fb2b34aa8386847a7a158a2cab551"
  license "GPL-3.0-or-later"
  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "de9d26c9d78740b7ad58babc927ee5aacdd3235698ca7ac146406ea76fd69298"
  end

  head "https://github.com/jubalh/nudoku.git", branch: "master"


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "pkgconf" => :build
  depends_on "cairo"

  depends_on "ncurses"

  on_macos do
    depends_on "gettext"
  end

  def install
    # AOSC OS provides a wide-char ncurses with a ncursesw.pc; the Homebrew
    # ncurses keg is built without wide-char support, so point configure at the
    # system one through the documented env-var override.
    ENV["ncursesw_CFLAGS"] = "-D_DEFAULT_SOURCE -D_XOPEN_SOURCE=600"
    ENV["ncursesw_LIBS"] = "-lncursesw"
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--disable-silent-rules",
                          "--enable-cairo",
                          *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "nudoku version #{version}", shell_output("#{bin}/nudoku -v")
  end
end
