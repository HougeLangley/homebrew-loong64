class Typespeed < Formula
  desc "Zap words flying across the screen by typing them correctly"
  homepage "https://typespeed.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/typespeed/typespeed/0.6.5/typespeed-0.6.5.tar.gz"
  sha256 "5c860385ceed8a60f13217cc0192c4c2b4705c3e80f9866f7d72ff306eb72961"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "70fdb8abd2d647ee7771227579fc6403a85ff312997f56a4ff077814ff815b1f"
  end


  uses_from_macos "ncurses"

  deny_network_access!

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    # Work around failure from GCC 10+ using default of `-fno-common`
    # multiple definition of `rules'; typespeed-file.o:(.bss+0x2050): first defined here
    # multiple definition of `words'; typespeed-file.o:(.bss+0x30): first defined here
    # multiple definition of `opt'; typespeed-file.o:(.bss+0x0): first defined here
    # multiple definition of `now'; typespeed-file.o:(.bss+0x30b0): first defined here
    ENV.append_to_cflags "-fcommon" if OS.linux?

    args = %W[--with-highscoredir=#{HOMEBREW_PREFIX}/var/cache]
    # Help old config scripts identify arm64 linux
    args << "--build=aarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    args << "--build=loongarch64-unknown-linux-gnu" if OS.linux? && Hardware::CPU.arch == :loongarch64

    # Fix the hardcoded gcc.
    inreplace "src/Makefile.in", "gcc", ENV.cc
    inreplace "testsuite/Makefile.in", "gcc", ENV.cc
    system "./configure", *args, *std_configure_args
    system "make", "install"
  end

  test do
    require "pty"

    # Pass the terminal size through the environment so curses sees it before the size check
    output = ""
    PTY.spawn({ "TERM" => "xterm", "LINES" => "24", "COLUMNS" => "24" }, bin/"typespeed") do |r, _w, pid|
      begin
        r.each_line { |line| output += line }
      rescue Errno::EIO
        # GNU/Linux raises EIO when read is done on closed pty
      end
      Process.wait(pid)
    end
    assert_equal 1, $CHILD_STATUS.exitstatus
    assert_match "You need at least 80 x 24 terminal!", output
  end
end
