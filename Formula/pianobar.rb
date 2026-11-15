class Pianobar < Formula
  desc "Command-line player for https://pandora.com"
  homepage "https://6xq.net/pianobar/"
  url "https://6xq.net/pianobar/pianobar-2024.12.21.tar.bz2"
  sha256 "16f4dd2d64da38690946a9670e59bc72a789cf6a323f792e159bb3a39cf4a7f5"
  license "MIT"
  revision 2
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "ec88c664f10f8f9448ca8426b6b8a44bac76726fbf9c182407173d34f2c040ef"
  end

  head "https://codeberg.org/purplesym/pianobar.git", branch: "master"

  livecheck do
    url :homepage
    regex(/href=.*?pianobar[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  depends_on "pkgconf" => :build
  depends_on "ffmpeg"
  depends_on "json-c"
  depends_on "libao"
  depends_on "libgcrypt"

  uses_from_macos "curl"

  def install
    # Discard Homebrew's CFLAGS as Pianobar reportedly doesn't like them
    ENV["CFLAGS"] = "-O2 -DNDEBUG " +
                    # Or it doesn't build at all
                    "-std=c99 " +
                    # build if we aren't /usr/local'
                    "#{ENV.cppflags} #{ENV.ldflags}"
    system "make", "PREFIX=#{prefix}"
    system "make", "install", "PREFIX=#{prefix}"

    prefix.install "contrib"
  end

  test do
    assert_match "pianobar (#{version})", pipe_output(bin/"pianobar", "\n", 0)
  end
end
