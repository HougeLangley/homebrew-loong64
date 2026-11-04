class Npush < Formula
  desc "Logic game similar to Sokoban and Boulder Dash"
  homepage "https://npush.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/npush/npush/0.7/npush-0.7.tgz"
  sha256 "f216d2b3279e8737784f77d4843c9e6f223fa131ce1ebddaf00ad802aba2bcd9"
  license "GPL-2.0-or-later"
  head "https://svn.code.sf.net/p/npush/code/"


  uses_from_macos "ncurses"

  deny_network_access!

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "71a89ab4e2db2710a05d8ca2164b27ce159337305833c18e6d4299c94ce63a51"
  end

  def install
    # Temporary Homebrew-specific work around for linker flag ordering problem in Ubuntu 16.04.
    # Remove after migration to 18.04.
    inreplace "Makefile", "$(PROGRAM) $(OBJECTS)", "$(PROGRAM) $(OBJECTS) -lncurses" unless OS.mac?
    system "make"
    pkgshare.install ["npush", "levels"]
    (bin/"npush").write <<~SH
      #!/bin/sh
      cd "#{pkgshare}" && exec ./npush $@
    SH
  end

  test do
    require "pty"
    require "expect"

    PTY.spawn({ "TERM" => "xterm" }, "#{bin}/npush") do |r, w, pid|
      r.winsize = [40, 100]
      refute_nil r.expect("Welcome to nPush", 10), "Expected main menu"
      w.write "\n"
      refute_nil r.expect("Level 01 - Gold and Exit", 10), "Expected level list"
      w.write "\n"
      refute_nil r.expect("Game Elements:", 10), "Expected first level to load"
      w.write "q"
      refute_nil r.expect("Welcome to nPush", 10), "Expected return to main menu"
      # Wrap around from the first menu item to "Quit"
      w.write "\eOA\n"
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
