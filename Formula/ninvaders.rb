class Ninvaders < Formula
  desc "Space Invaders in the terminal"
  homepage "https://ninvaders.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/ninvaders/ninvaders/0.1.1/ninvaders-0.1.1.tar.gz"
  sha256 "bfbc5c378704d9cf5e7fed288dac88859149bee5ed0850175759d310b61fd30b"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "6a26bd02d606b6a2fca5958d41614706a71f324698897340e50edfcfa25d92ae"
  end

  uses_from_macos "ncurses"

  def install
    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `skill_level'; aliens.o:(.bss+0x67c): first defined here
    inreplace "Makefile", "-Wall", "-Wall -fcommon" if OS.linux?

    # GCC 15+ defaults to C23, where () means a zero-argument prototype.
    %w[globals.h nInvaders.h].each do |header|
      inreplace header, "extern void doSleep();", "extern void doSleep(int microseconds);"
    end
    inreplace "nInvaders.c", "void handleTimer()", "void handleTimer(int signum)"

    ENV.deparallelize # this formula's build system can't parallelize
    inreplace "Makefile" do |s|
      s.change_make_var! "CC", ENV.cc
      # gcc-4.2 doesn't like the lack of space here
      s.gsub! "-o$@", "-o $@"
    end
    system "make" # build the binary
    bin.install "nInvaders"
  end

  test do
    assert_match "nInvaders #{version}",
      shell_output("#{bin}/nInvaders -h 2>&1", 1)
  end
end
