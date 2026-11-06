class Wiggle < Formula
  desc "Program for applying patches with conflicting changes"
  homepage "https://github.com/neilbrown/wiggle"
  url "https://github.com/neilbrown/wiggle/archive/refs/tags/v1.3.tar.gz"
  sha256 "ff92cf0133c1f4dce33563e263cb30e7ddb6f4abdf86d427b1ec1490bec25afa"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8494176cef0ae77c3b83bbd160f69a2c072a2bec2a10e0b524d72b268d82b670"
  end

  uses_from_macos "ncurses"


  def install
    system "make", "OptDbg=#{ENV.cflags}", "PREFIX=#{prefix}", "test", "install"
  end

  test do
    system bin/"wiggle", "--version"
  end
end
