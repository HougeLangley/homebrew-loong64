class Ssocr < Formula
  desc "Seven Segment Optical Character Recognition"
  homepage "https://www.unix-ag.uni-kl.de/~auerswal/ssocr/"
  url "https://www.unix-ag.uni-kl.de/~auerswal/ssocr/ssocr-2.25.1.tar.bz2"
  sha256 "e7588bb9ec56b568362ca0b68c216b0af37b42bb3f63602ee21628aa731b84be"
  license "GPL-3.0-or-later"
  head "https://github.com/auerswal/ssocr.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "990a774afa3a6b0ce8eb6cdff1e3ac9e9778f7d286d50fc19c2980e5cd4f5021"
  end

  livecheck do
    url :homepage
    regex(/href=.*?ssocr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "pkgconf" => :build
  depends_on "imlib2"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    # A seven-segment "431432"; drawn here because fetching a sample image hangs on some runners
    display = <<~DIGITS
      ..............#######..........................#######....#######...
      ..#.......#..........#..........#..#.......#..........#..........#..
      ..#.......#..........#..........#..#.......#..........#..........#..
      ..#.......#..........#..........#..#.......#..........#..........#..
      ..#.......#..........#..........#..#.......#..........#..........#..
      ..#.......#..........#..........#..#.......#..........#..........#..
      ...#######....#######...............#######....#######....#######...
      ..........#..........#..........#..........#..........#..#..........
      ..........#..........#..........#..........#..........#..#..........
      ..........#..........#..........#..........#..........#..#..........
      ..........#..........#..........#..........#..........#..#..........
      ..........#..........#..........#..........#..........#..#..........
      ..............#######..........................#######....#######...
    DIGITS

    rows = display.lines.map(&:chomp)
    (testpath/"digits.pbm").write <<~PBM
      P1
      #{rows.first.length} #{rows.length}
      #{rows.join("\n").tr(".#", "01")}
    PBM

    assert_equal "431432", shell_output("#{bin}/ssocr -T #{testpath}/digits.pbm").chomp
  end
end
