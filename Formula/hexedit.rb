class Hexedit < Formula
  desc "View and edit files in hexadecimal or ASCII"
  homepage "https://rigaux.org/hexedit.html"
  url "https://github.com/pixel/hexedit/archive/refs/tags/1.6.tar.gz"
  sha256 "598906131934f88003a6a937fab10542686ce5f661134bc336053e978c4baae3"
  license "GPL-2.0-or-later"
  head "https://github.com/pixel/hexedit.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "5d3b9391b2a29cfc15112a877e6863d4a496af698d43f8215d72a51096cdefa9"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "ncurses"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/hexedit -h 2>&1", 1)
  end
end
