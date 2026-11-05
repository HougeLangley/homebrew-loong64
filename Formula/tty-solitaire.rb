class TtySolitaire < Formula
  desc "Ncurses-based klondike solitaire game"
  homepage "https://github.com/mpereira/tty-solitaire"
  url "https://github.com/mpereira/tty-solitaire/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "8eb536a87f0586e1f057a3aa05256df34cbd92a3e22545d1df2f945e27d89db2"
  license "MIT"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "43dde2871b97659c74dfde813f556597b343e283e496083b2288201472b2ae12"
  end


  uses_from_macos "ncurses"


  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system bin/"ttysolitaire", "-h"
  end
end
