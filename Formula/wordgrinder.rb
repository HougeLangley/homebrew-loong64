class Wordgrinder < Formula
  desc "Unicode-aware word processor that runs in a terminal"
  homepage "https://cowlark.com/wordgrinder"
  url "https://github.com/davidgiven/wordgrinder/archive/refs/tags/0.8.tar.gz"
  sha256 "856cbed2b4ccd5127f61c4997a30e642d414247970f69932f25b4b5a81b18d3f"
  license "MIT"
  revision 1
  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "103aa283a149744e10d8128b1d319785d37d56bdba39f598c5972c0364df8d80"
  end

  head "https://github.com/davidgiven/wordgrinder.git", branch: "master"



  depends_on "lua" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "ncurses"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    ENV["CURSES_PACKAGE"] = "ncursesw"
    system "make", "OBJDIR=#{buildpath}/wg-build"
    bin.install "bin/wordgrinder-builtin-curses-release" => "wordgrinder"
    man1.install "bin/wordgrinder.1"
    doc.install "README.wg"
  end

  test do
    system bin/"wordgrinder", "--convert", "#{doc}/README.wg", testpath/"converted.txt"
    assert_path_exists testpath/"converted.txt"
  end
end
