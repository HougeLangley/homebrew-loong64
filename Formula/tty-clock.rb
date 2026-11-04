class TtyClock < Formula
  desc "Digital clock in ncurses"
  homepage "https://github.com/xorg62/tty-clock"
  url "https://github.com/xorg62/tty-clock/archive/refs/tags/v2.3.tar.gz"
  sha256 "343e119858db7d5622a545e15a3bbfde65c107440700b62f9df0926db8f57984"
  license "BSD-3-Clause"
  head "https://github.com/xorg62/tty-clock.git", branch: "master"


  depends_on "pkgconf" => :build

  uses_from_macos "ncurses"

  def install
    ENV.append "LDFLAGS", "-lncurses"
    system "make", "PREFIX=#{prefix}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"tty-clock", "-i"
  end
end
