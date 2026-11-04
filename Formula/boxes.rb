class Boxes < Formula
  desc "Draw boxes around text"
  homepage "https://boxes.thomasjensen.com/"
  url "https://github.com/ascii-boxes/boxes/archive/refs/tags/v2.3.2.tar.gz"
  sha256 "9318ef65f555ee3d893176349a4219f1f1260ce24d4100aeb667a546f61fc183"
  license "GPL-3.0-only"
  head "https://github.com/ascii-boxes/boxes.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "bd62bb53c7aa718bf18c365ae1b50acfdedb7ff0c800fdc7fefda9b28d4f4dc3"
  end

  depends_on "bison" => :build
  depends_on "libunistring"
  depends_on "pcre2"

  uses_from_macos "flex" => :build
  uses_from_macos "ncurses"

  def install
    # distro uses /usr/share/boxes change to prefix
    system "make", "GLOBALCONF=#{share}/boxes-config",
                   "CC=#{ENV.cc}",
                   "YACC=#{formula_opt_bin("bison")/"bison"}"

    bin.install "out/boxes"
    man1.install "doc/boxes.1"
    share.install "boxes-config"
  end

  test do
    assert_match "test brew", pipe_output(bin/"boxes", "test brew", 0)
  end
end
