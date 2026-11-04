class Dwm < Formula
  desc "Dynamic window manager"
  homepage "https://dwm.suckless.org/"
  url "https://dl.suckless.org/dwm/dwm-6.8.tar.gz"
  sha256 "bcf540589ad174d4073f4efa658828411e2f5ba63196cfaf6b71363700f590b7"
  license "MIT"
  head "https://git.suckless.org/dwm/", using: :git, branch: "master"

  livecheck do
    url "https://dl.suckless.org/dwm/"
    regex(/href=.*?dwm[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "b3ced5a80d8ac03d369c6aa52a27032333162dc2ec8e73a3af2dd091b7f5da27"
  end

  depends_on "dmenu"
  depends_on "fontconfig"
  depends_on "libx11"
  depends_on "libxft"
  depends_on "libxinerama"

  def install
    if OS.mac?
      # The dwm default quit keybinding Mod1-Shift-q collides with
      # the Mac OS X Log Out shortcut in the Apple menu.
      inreplace "config.def.h",
      "{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },",
      "{ MODKEY|ControlMask,           XK_q,      quit,           {0} },"
      inreplace "dwm.1", '.B Mod1\-Shift\-q', '.B Mod1\-Control\-q'
    end
    system "make", "FREETYPEINC=#{formula_opt_include("freetype2")}/freetype2", "PREFIX=#{prefix}", "install"
  end

  def caveats
    on_macos do
      <<~EOS
        In order to use the Mac OS X command key for dwm commands,
        change the X11 keyboard modifier map using xmodmap (1).

        e.g. by running the following command from $HOME/.xinitrc
        xmodmap -e 'remove Mod2 = Meta_L' -e 'add Mod1 = Meta_L'&

        See also https://gist.github.com/311377 for a handful of tips and tricks
        for running dwm on Mac OS X.
      EOS
    end
  end

  test do
    assert_match "dwm: cannot open display", shell_output("DISPLAY= #{bin}/dwm 2>&1", 1)
    assert_match "dwm-#{version}", shell_output("DISPLAY= #{bin}/dwm -v 2>&1", 1)
  end
end
