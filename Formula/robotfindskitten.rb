class Robotfindskitten < Formula
  desc "Zen Simulation of robot finding kitten"
  homepage "https://robotfindskitten.org/"
  url "https://codeberg.org/robotfindskitten/robotfindskitten/releases/download/3.0000000.726/robotfindskitten-3.0000000.726.tar.gz"
  sha256 "290172b0a04c9a80400bc3b668eb844e24b03a377e2a6b349218b56f7106a1b7"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/^(\d+(?:\.\d+)+)$/i) # Exclude tags that start with `v`
  end


  head do
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "535ec4b365ec6e97c6a1031571f8fad85a6c60e53eb83252c1a2e8a026a25c37"
  end

    url "https://codeberg.org/robotfindskitten/robotfindskitten.git", branch: "main"

    # Used for building shipped robotfindskitten.info from robotfindskitten.texi
    depends_on "texinfo" => :build
  end


  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  uses_from_macos "ncurses"

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install", "execgamesdir=#{bin}"
  end

  test do
    assert_equal "robotfindskitten: #{version}",
      shell_output("#{bin}/robotfindskitten -V").chomp
  end
end
