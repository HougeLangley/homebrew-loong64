class Gnuski < Formula
  desc "Open source clone of Skifree"
  homepage "https://gnuski.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/gnuski/gnuski/gnuski-0.3/gnuski-0.3.tar.gz"
  sha256 "1b629bd29dd6ad362b56055ccdb4c7ad462ff39d7a0deb915753c2096f5f959d"
  license "GPL-2.0-or-later"


  uses_from_macos "ncurses"

  deny_network_access!

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "2b7647d340855d995bdf2974af2ad453f12f9729a7ec68f406c9d4e5f51e8762"
  end

  def install
    # https://sourceforge.net/p/gnuski/patches/2/
    inreplace "objects.h", "#endif", "void setupColors ();\n#endif"
    system "make"
    bin.install "gnuski"
  end

  test do
    require "expect"
    require "pty"

    PTY.spawn({ "TERM" => "xterm" }, bin/"gnuski") do |r, w, pid|
      r.winsize = [24, 80]
      refute_nil r.expect("Press any key to start...", 10), "Expected start prompt"
      w.write "\r"

      # Keep draining the screen so the game doesn't block on a full pty while the skier crashes
      output = +""
      reader = Thread.new do
        loop { output << r.readpartial(4096) }
      rescue Errno::EIO, IOError
        # GNU/Linux raises EIO when read is done on closed pty
      end

      sleep 10
      w.write "\r"
      Timeout.timeout(10) { Process.wait(pid) }
      reader.join(5)

      assert_equal 0, $CHILD_STATUS.exitstatus
      assert_match "Press any key to continue...", output
    ensure
      r.close
      w.close
    end
  end
end
