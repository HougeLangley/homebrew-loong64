class Rlwrap < Formula
  desc "Readline wrapper: adds readline support to tools that lack it"
  homepage "https://github.com/hanslub42/rlwrap"
  url "https://github.com/hanslub42/rlwrap/releases/download/v0.48/rlwrap-0.48.zip"
  sha256 "50ab1eabbb4f5d8a74bcd49bdee91342206c86695a0b63063f48dd682770d5a2"
  license "GPL-2.0-or-later"
  compatibility_version 1

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bb04471fdfaabed071106c042fd1cbdd9e6768a65296d5253d627a86e8ec98c9"
  end

  head do
    url "https://github.com/hanslub42/rlwrap.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end


  depends_on "libptytty"
  depends_on "readline"

  uses_from_macos "ncurses"

  def install
    system "autoreconf", "--force", "--install", "--verbose" if build.head?
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"rlwrap", "--version"
  end
end
