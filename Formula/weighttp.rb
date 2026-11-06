class Weighttp < Formula
  desc "Webserver benchmarking tool that supports multithreading"
  homepage "https://redmine.lighttpd.net/projects/weighttp/wiki"
  url "https://github.com/lighttpd/weighttp/archive/refs/tags/weighttp-0.5.tar.gz"
  sha256 "5900600cc108041d0e38abd02354d7d3b14649c827c4266c0d550b87904f1141"
  license "MIT"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "30a07524e057421229fd10c1a249f0750cc1a3141f1cca80a1f0602815002352"
  end

  head "https://git.lighttpd.net/lighttpd/weighttp.git", branch: "master"



  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build
  depends_on "libev"

  allow_network_access! :test

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    # Stick with HTTP to avoid 'error: no ssl support yet'
    system bin/"weighttp", "-n", "1", "http://redmine.lighttpd.net/projects/weighttp/wiki"
  end
end
