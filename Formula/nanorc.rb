class Nanorc < Formula
  desc "Improved Nano Syntax Highlighting Files"
  homepage "https://github.com/scopatz/nanorc"
  url "https://github.com/scopatz/nanorc/releases/download/2020.10.10/nanorc-2020.10.10.tar.gz"
  sha256 "cd674e9eb230e4ba306b418c22d1891d93a3d2ffdf22234748d3398da50dfe64"
  license "GPL-3.0-or-later"
  head "https://github.com/scopatz/nanorc.git", branch: "master"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "1f2e392a1ea501509719f7cd4159346fe0f66fae2614672105a9e64cf49d8f1d"
  end

  def install
    pkgshare.install Dir["*.nanorc"]
    doc.install %w[readme.md license]
  end

  test do
    require "pty"
    PTY.spawn("nano", "--rcfile=#{pkgshare}/c.nanorc") do |_stdout, _stdin, pid|
      sleep 3
      Process.kill "TERM", pid
    end
  end
end
