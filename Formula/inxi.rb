class Inxi < Formula
  desc "Full featured CLI system information tool"
  homepage "https://smxi.org/docs/inxi.htm"
  url "https://codeberg.org/smxi/inxi/archive/3.3.41-1.tar.gz"
  sha256 "e08d92550a0f10890e722cc7db1e6d6cbde7e9fb47e61a8c6cec51f54a0b63d8"
  license "GPL-3.0-or-later"
  head "https://codeberg.org/smxi/inxi.git", branch: "master"


  uses_from_macos "perl"

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "9c53e4f0c9ea5e769811ac13ab069641f298cf18c76d1b6ba3732e5041c1be89"
  end

  def install
    bin.install "inxi"
    man1.install "inxi.1"

    # Build an `:all` bottle
    inreplace "inxi.changelog", "/usr/local/etc/inxi", "#{HOMEBREW_PREFIX}/etc/inxi"

    ["LICENSE.txt", "README.txt", "inxi.changelog"].each do |file|
      prefix.install file
    end
  end

  test do
    inxi_output = shell_output(bin/"inxi")
    uname_r = shell_output("uname -r").strip
    assert_match uname_r.to_str, inxi_output.to_s
  end
end
