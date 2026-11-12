class Bvi < Formula
  desc "Vi-like binary file (hex) editor"
  homepage "https://bvi.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/bvi/bvi/1.5.0/bvi-1.5.0.src.tar.gz"
  sha256 "6540716a1a3b2b9711635108da14b26baea488881d4a682121c0bddbba6b74cb"
  license "GPL-3.0-or-later"


  uses_from_macos "ncurses"

  deny_network_access!

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "34b41ef7121961629dfbad8b5d102c685cd0dbe290aa77ca3b2f3310c3ba3c3d"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    if OS.linux? && ENV["HOMEBREW_GITHUB_ACTIONS"]
      out = shell_output("#{bin}/bvi -c q", 1)
      assert_match out, "Input is not from a terminal"
    else
      system bin/"bvi", "-c", "q"
    end
  end
end
