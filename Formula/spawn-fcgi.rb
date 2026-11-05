class SpawnFcgi < Formula
  desc "Spawn FastCGI processes"
  homepage "https://redmine.lighttpd.net/projects/spawn-fcgi"
  url "https://download.lighttpd.net/spawn-fcgi/releases-1.6.x/spawn-fcgi-1.6.6.tar.gz"
  sha256 "4ffe2e9763cf71ca52c3d642a7bfe20d6be292ba0f2ec07a5900c3110d0e5a85"
  license "BSD-3-Clause"
  head "https://git.lighttpd.net/lighttpd/spawn-fcgi.git", branch: "master"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "8b295fba0295ede6c9cd005d95807e0fb7bb293b91baa56aec7d9e532b46e579"
  end

  livecheck do
    url :head
    regex(/^(?:spawn-fcgi-)?v?(\d+(?:\.\d+)+)$/i)
  end



  depends_on "meson" => :build
  depends_on "ninja" => :build

  def install
    # Fix compile with newer Clang
    ENV.append_to_cflags "-Wno-implicit-function-declaration" if DevelopmentTools.clang_build_version >= 1403

    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system bin/"spawn-fcgi", "--version"
  end
end
