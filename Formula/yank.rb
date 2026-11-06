class Yank < Formula
  desc "Copy terminal output to clipboard"
  homepage "https://github.com/mptre/yank"
  url "https://github.com/mptre/yank/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "0f1d1000f358bfa373f3903ea2871e2585fa694a0b03d8ff7561c1205207dec5"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bdfb3204641b4171f25e2cf251acdd490d73f30d47d370fbaffa0cdd8d180c5c"
  end

  on_linux do
    depends_on "xsel"
  end

  deny_network_access!


  def install
    yankcmd = OS.mac? ? "pbcopy" : "xsel"
    system "make", "install", "PREFIX=#{prefix}", "YANKCMD=#{yankcmd}"
  end

  test do
    require "pty"
    PTY.spawn("echo key=value | #{bin}/yank -d = >#{testpath}/result") do |r, w, _pid|
      r.winsize = [80, 43]
      w.write "\016"
      sleep 1
      w.write "\r"
      sleep 1
    end
    assert_equal "value", (testpath/"result").read
  end
end
