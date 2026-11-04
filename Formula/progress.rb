class Progress < Formula
  desc "Coreutils progress viewer"
  homepage "https://github.com/Xfennec/progress"
  url "https://github.com/Xfennec/progress/archive/refs/tags/v0.17.tar.gz"
  sha256 "ee9538fce98895dcf0d108087d3ee2e13f5c08ed94c983f0218a7a3d153b725d"
  license "GPL-3.0-or-later"
  head "https://github.com/Xfennec/progress.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ef5b5225c97b43109ba21552566aee78ea486c305f6bd0ee2006852e0cc5cb96"
  end



  depends_on "pkgconf" => :build
  uses_from_macos "ncurses"

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    pid = spawn "/bin/dd", "if=/dev/urandom", "of=foo", "bs=512", "count=1048576"
    sleep 1
    begin
      assert_match "dd", shell_output(bin/"progress")
    ensure
      Process.kill 9, pid
      Process.wait pid
      rm "foo"
    end
  end
end
