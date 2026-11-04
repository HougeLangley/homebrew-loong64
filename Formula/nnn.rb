class Nnn < Formula
  desc "Tiny, lightning fast, feature-packed file manager"
  homepage "https://github.com/jarun/nnn"
  url "https://github.com/jarun/nnn/archive/refs/tags/v5.3.tar.gz"
  sha256 "79ee69f3ced7c0778d207df76b4d4d680636975ccda002eeb19d0917fcba3d36"
  license "BSD-2-Clause"
  head "https://github.com/jarun/nnn.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "3b23fe0ed741f2f0a0e44afcc19a84015be1537d8715de9dbaa76ab030984c8c"
  end



  depends_on "gnu-sed"
  depends_on "ncurses"
  depends_on "readline"

  def install
    system "make", "install", "PREFIX=#{prefix}"

    bash_completion.install "misc/auto-completion/bash/nnn-completion.bash" => "nnn"
    zsh_completion.install "misc/auto-completion/zsh/_nnn"
    fish_completion.install "misc/auto-completion/fish/nnn.fish"

    pkgshare.install "misc/quitcd"
  end

  test do
    # Testing this curses app requires a pty
    require "pty"

    # nnn 5.3 aborts if XDG_CONFIG_HOME is set but not an accessible directory
    ENV["XDG_CONFIG_HOME"] = testpath

    (testpath/"testdir").mkdir
    PTY.spawn(bin/"nnn", testpath/"testdir") do |r, w, pid|
      w.write "q"
      output = if OS.mac?
        r.read
      else
        Process.wait(pid)
        r.read_nonblock(4096)
      end
      assert_match "~/testdir", output
    end
  end
end
