class Mpdscribble < Formula
  desc "Last.fm reporting client for mpd"
  homepage "https://www.musicpd.org/clients/mpdscribble/"
  url "https://www.musicpd.org/download/mpdscribble/0.26/mpdscribble-0.26.tar.xz"
  sha256 "b9d5829b89c465707256c140000e1a04b1d9d3afe50db46a843cf5ee54bf6309"
  license "GPL-2.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?mpdscribble[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f6be985365c965c30b72fedc7ee994f6884d988d57d02525308172a72085239b"
  end

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "fmt"
  depends_on "libgcrypt"
  depends_on "libmpdclient"

  uses_from_macos "curl"

  def install
    system "meson", "setup", "build", "--sysconfdir=#{etc}", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  def caveats
    <<~EOS
      The configuration file has been placed in #{etc}/mpdscribble.conf.
    EOS
  end

  service do
    run [opt_bin/"mpdscribble", "--no-daemon"]
    keep_alive true
    working_dir HOMEBREW_PREFIX
  end

  test do
    assert_match "No 'username'", shell_output("#{bin}/mpdscribble --no-daemon 2>&1", 1)

    assert_match version.to_s, shell_output("#{bin}/mpdscribble --version")
  end
end
