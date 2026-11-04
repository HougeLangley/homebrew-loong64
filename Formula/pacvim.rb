class Pacvim < Formula
  desc "Learn vim commands via a game"
  homepage "https://github.com/jmoon018/PacVim"
  url "https://github.com/jmoon018/PacVim/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "c869c5450fbafdfe8ba8a8a9bba3718775926f276f0552052dcfa090d21acb28"
  license "LGPL-3.0-or-later"
  head "https://github.com/jmoon018/PacVim.git", branch: "master"


  uses_from_macos "ncurses"

  # Use ncurses.h instead of cursesw.h which is not installed by brew
  patch do
    on_linux do
      url "https://github.com/jmoon018/PacVim/commit/2f95ef4d312d760b8a3aae463e959646b27e774a.patch?full_index=1"
      sha256 "e5b753de87937c0853a1adbab31eb1ec938add4ceb0df26eafef5b4f613bc3e6"
      type :unofficial
      resolves "https://github.com/jmoon018/PacVim/pull/31"
    end
  end

  deny_network_access!

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a5d413c1d12543c70e7cc1080270eef26c6159684d5f428a954d0f7577edf281"
  end

  def install
    ENV.cxx11
    inreplace "src/globals.h", "#include <set>", "#include <set>\n#include <string>"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    require "pty"
    require "expect"

    PTY.spawn({ "TERM" => "xterm" }, "#{bin}/pacvim", "10") do |r, _w, pid|
      r.winsize = [40, 100]
      refute_nil r.expect("Invalid starting level.", 10), "Expected invalid level error"
      r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    ensure
      r.close
      Process.wait(pid)
    end

    PTY.spawn({ "TERM" => "xterm" }, "#{bin}/pacvim", "0") do |r, w, pid|
      r.winsize = [40, 100]
      refute_nil r.expect("LEVEL 0", 10), "Expected level banner"
      # Text from the installed map0.txt
      refute_nil r.expect("Every", 10), "Expected map to be drawn"
      refute_nil r.expect("PRESS ENTER TO PLAY!", 10), "Expected start prompt"
      w.write "q"
      r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    ensure
      r.close
      w.close
      Process.wait(pid)
    end
    assert_equal 0, $CHILD_STATUS.exitstatus
  end
end
