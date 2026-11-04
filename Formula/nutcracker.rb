class Nutcracker < Formula
  desc "Proxy for memcached and redis"
  homepage "https://github.com/twitter/twemproxy"
  url "https://github.com/twitter/twemproxy/archive/refs/tags/0.5.0.tar.gz"
  sha256 "73f305d8525abbaaa6a5f203c1fba438f99319711bfcb2bb8b2f06f0d63d1633"
  license "Apache-2.0"
  revision 1
  head "https://github.com/twitter/twemproxy.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "a8cc5c77ef72dc6be698d5202cc97202cf8532db916c24820b5872656275dab5"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libyaml"

  # Use Homebrew libyaml instead of the vendored one.
  # Adapted from Debian's equivalent patch.
  patch do
    file "Patches/nutcracker/use-system-libyaml.patch"
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make", "install"

    pkgshare.install "conf", "notes", "scripts"
  end

  test do
    assert_match version.to_s, shell_output("#{sbin}/nutcracker -V 2>&1")
  end
end
