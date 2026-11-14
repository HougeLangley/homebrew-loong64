class VideoCompare < Formula
  desc "Split screen video comparison tool using FFmpeg and SDL2"
  homepage "https://github.com/pixop/video-compare"
  url "https://github.com/pixop/video-compare/archive/refs/tags/20261004.tar.gz"
  sha256 "65555c2bb4f76dee86666ad047e3b335f9f486d036402faebf97bd40ada7209e"
  license "GPL-2.0-only"



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "9613876bbc887b3f3d98159002fb4a8aee133eaf54f904ad1bbc5719bc859a42"
  end

  depends_on "ffmpeg"
  depends_on "sdl2-compat"
  depends_on "sdl2_ttf"

  def install
    system "make"
    bin.install "video-compare"
  end

  test do
    testvideo = test_fixtures("test.gif") # GIF is valid ffmpeg input format
    begin
      pid = spawn bin/"video-compare", testvideo, testvideo
      sleep 3
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
