class Zork < Formula
  desc "Dungeon modified from FORTRAN to C"
  homepage "https://github.com/devshane/zork"
  url "https://github.com/devshane/zork/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "df2934f886d9d225f27062a783df3f32d73151d32f53b20f37415492932837e4"
  license :public_domain
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ffae21911b645253c107edd6767d9e7ba90665d063eb93b2b20c6fe1bd366694"
  end

  head "https://github.com/devshane/zork.git", branch: "master"


  uses_from_macos "ncurses"

  deny_network_access!


  def install
    system "make", "DATADIR=#{share}", "BINDIR=#{bin}"
    system "make", "install", "DATADIR=#{share}", "BINDIR=#{bin}", "MANDIR=#{man}"
  end

  test do
    test_phrase = <<~EOS.chomp
      Welcome to Dungeon.\t\t\tThis version created 11-MAR-91.
      You are in an open field west of a big white house with a boarded
      front door.
      There is a small mailbox here.
      >Opening the mailbox reveals:
        A leaflet.
      >
    EOS
    assert_equal test_phrase, pipe_output(bin/"zork", "open mailbox", 0)
  end
end
