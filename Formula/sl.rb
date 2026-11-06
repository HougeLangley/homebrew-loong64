class Sl < Formula
  desc "Prints a steam locomotive if you type sl instead of ls"
  homepage "https://github.com/mtoyoda/sl"
  url "https://github.com/mtoyoda/sl/archive/refs/tags/5.02.tar.gz"
  sha256 "1e5996757f879c81f202a18ad8e982195cf51c41727d3fea4af01fdcbbb5563a"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7dccbe9b0fac15098cb1e99c8680e7a88943fbfaaa35762e38cef3e5cec92a57"
  end

  head "https://github.com/mtoyoda/sl.git", branch: "master"


  uses_from_macos "ncurses"

  conflicts_with "sapling", because: "both install `sl` binaries"

  deny_network_access!


  def install
    system "make", "-e"
    bin.install "sl"
    man1.install "sl.1"
  end

  test do
    system bin/"sl", "-c"
  end
end
