class Focus < Formula
  desc "A fully featured productivity timer for the command line, based on the Pomodoro Technique."
  homepage "https://example.org/focus"
  version "1.4.3"
  url "http://127.0.0.1:8080/brew/bottles/focus--1.4.3.loongarch64.bottle.tar.gz"
  sha256 "9d47eb266ae853e1ee463f9d3dc17d4a395ac9c9ba6b983a33517ab09713f3d3"

  def install
    bin.install "focus"
  end

  test do
    system "#{bin}/focus"
  end
end
