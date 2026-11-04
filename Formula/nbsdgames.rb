class Nbsdgames < Formula
  desc "Text-based modern games"
  homepage "https://github.com/abakh/nbsdgames"
  url "https://github.com/abakh/nbsdgames/archive/refs/tags/v6.0.3.tar.gz"
  sha256 "359da5f698da00437205eddad3fc97fbdcecfa8cb005fd8d1830fe8fd3dd7e3b"
  license :public_domain
  head "https://github.com/abakh/nbsdgames.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fa9fc4758e5da45fdb6b9f22a199f03768e4be1d895af28c86c8ba6953bf19d3"
  end

  depends_on "pkgconf" => :build

  uses_from_macos "ncurses"

  def install
    mkdir bin
    system "make", "install",
           "GAMES_DIR=#{bin}",
           "SCORES_DIR=#{var}/games",
           "MAN_DIR=#{man}",
           "LIBS_PKG_CONFIG=-lncurses"

    man6.mkpath
    system "make", "manpages", "MAN_DIR=#{man6}"
  end

  test do
    assert_equal "2 <= size <= 7", shell_output("#{bin}/sudoku -s 1", 1).chomp
  end
end
