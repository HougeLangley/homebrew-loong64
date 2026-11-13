class Mg < Formula
  desc "Small Emacs-like editor"
  homepage "https://github.com/ibara/mg"
  url "https://github.com/ibara/mg/releases/download/mg-7.3/mg-7.3.tar.gz"
  sha256 "1fd52feed9a96b93ef16c28ec4ff6cb25af85542ec949867bffaddee203d1e95"
  license all_of: [:public_domain, "ISC", "BSD-2-Clause", "BSD-3-Clause", "BSD-4-Clause"]
  version_scheme 1


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "74156b54700c798bd8ed0b1ce7577c9eecd1e596c639d261674080980be5b348"
  end

  uses_from_macos "ncurses"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}"
    # GCC 16 defaults to C23 and rejects login_tty()'s implicit declaration.
    # Keep configure's Linux CFLAGS (including st_mtimespec=st_mtim) and only
    # append the compatibility tolerances instead of overriding CFLAGS.
    inreplace "Makefile", /^CFLAGS\s*=\s*/,
              "CFLAGS = -std=gnu17 -Wno-error=implicit-function-declaration " \
              "-Wno-implicit-function-declaration "
    system "make"
    system "make", "install"
  end

  test do
    require "pty"
    PTY.spawn({ "TERM" => "xterm" }, bin/"mg", "test") do |r, w, pid|
      sleep 1
      w.write "brew\n\u0018\u0003y"
      r.read
    rescue Errno::EIO
      # GNU/Linux raises EIO when read is done on closed pty
    ensure
      r.close
      w.close
      Process.wait(pid)
    end
    assert_equal "brew\n", (testpath/"test").read
  end
end
