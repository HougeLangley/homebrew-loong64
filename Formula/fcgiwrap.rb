class Fcgiwrap < Formula
  desc "CGI support for Nginx"
  homepage "https://www.nginx.com/resources/wiki/start/topics/examples/fcgiwrap/"
  url "https://github.com/gnosek/fcgiwrap/archive/refs/tags/1.1.0.tar.gz"
  sha256 "4c7de0db2634c38297d5fcef61ab4a3e21856dd7247d49c33d9b19542bd1c61f"
  license "MIT"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "6cc82ce62ccb0273e87090984cdd8526cc0cd25e426daf1680cd7f7707e43719"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "fcgi"

  deny_network_access!

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--mandir=#{man}", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "Invokes CGI scripts as FCGI.", shell_output("#{sbin}/fcgiwrap -h")
  end
end
