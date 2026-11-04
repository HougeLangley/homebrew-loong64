class Lcs < Formula
  desc "Satirical console-based political role-playing/strategy game"
  homepage "https://sourceforge.net/projects/lcsgame/"
  url "https://github.com/ashley-s-fox/Liberal-Crime-Squad/archive/59744167aff8d39b8e4b36fa2b529ad5671c9dd0.tar.gz"
  version "4.07.4b"
  sha256 "77832463f2c244e346b869d6e8586856d34134e32df02a3a1c54a7efd77ca445"
  license "GPL-2.0-or-later"
  head "https://svn.code.sf.net/p/lcsgame/code/trunk"

  # This formula is using an unstable trunk version and we can't reliably
  # identify new versions in this case, so we skip it unless/until it's updated
  # to use a stable version in the future.
  livecheck do
    skip "Formula uses an unstable trunk version"
  end


  # Last version update was 2013-10-20 and last activity was 2015-09-25.
  # Since then, multiple forks have been in use by community, i.e.
  # https://github.com/Kamal-Sadek/Liberal-Crime-Squad and
  # https://github.com/King-Drake/Liberal-Crime-Squad, but
  # these won't meet Homebrew's exception as no major distro packages lcs
  deprecate! date: "2026-10-17", because: :unmaintained
  disable! date: "2027-04-17", because: :unmaintained

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "32301fe53859b3300c6f11c9d47334dcb97a35abe4f5a00c7a9cb7785b0689d9"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  uses_from_macos "ncurses"

  deny_network_access!

  def install
    # Workaround for newer Clang
    ENV.append_to_cflags "-Wno-c++11-narrowing" if DevelopmentTools.clang_build_version >= 1403

    system "./bootstrap"
    libs = OS.mac? ? "-liconv" : ""
    system "./configure", "LIBS=#{libs}", *std_configure_args
    system "make", "install"
  end

  test do
    require "pty"
    require "expect"

    PTY.spawn({ "TERM" => "xterm", "HOME" => testpath.to_s }, bin/"crimesquad") do |r, w, pid|
      r.winsize = [25, 80]
      refute_nil r.expect("Inspired by the 1983 version of Oubliette", 15), "Expected title screen"
      refute_nil r.expect("Liberal Agenda!", 10), "Expected title screen prompt"
      w.write "\e"
      r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    ensure
      r.close
      w.close
      Process.wait(pid)
    end

    assert_predicate testpath/".lcs", :directory?
  end
end
