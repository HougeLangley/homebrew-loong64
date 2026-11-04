class Aoeui < Formula
  desc "Lightweight text editor optimized for Dvorak and QWERTY keyboards"
  homepage "https://code.google.com/archive/p/aoeui/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/aoeui/aoeui-1.6.tgz"
  sha256 "0655c3ca945b75b1204c5f25722ac0a07e89dd44bbf33aca068e918e9ef2a825"
  license "GPL-2.0-only"


  uses_from_macos "m4" => :build

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "c17e1bb24d6b8a4fab96e204c67a60d11d46a08a239eef7a55d8cf232748766c"
  end

  def install
    system "make", "INST_DIR=#{prefix}", "install"
  end

  test do
    require "pty"
    PTY.spawn(bin/"aoeui", "test.txt") do |r, w, _pid|
      r.winsize = [80, 43]
      sleep 1
      w.write "brew"
      sleep 1
      w.write "\x00\x11"
      begin
        r.read
      rescue Errno::EIO
        # GNU/Linux raises EIO when read is done on closed pty
      end
    end
    assert_path_exists testpath/"test.txt"
    assert_match "brew", File.read("test.txt")
  end
end
