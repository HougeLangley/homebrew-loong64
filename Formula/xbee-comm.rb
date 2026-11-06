# This fork contains macOS patches.
# Original project: https://github.com/roysjosh/xbee-comm

class XbeeComm < Formula
  desc "XBee communication libraries and utilities"
  homepage "https://github.com/guyzmo/xbee-comm"
  url "https://github.com/guyzmo/xbee-comm/archive/refs/tags/v1.5.tar.gz"
  sha256 "c474d22feae5d9c05b3ec167b839c8fded512587da0f020ca682d60db174f24a"
  license "GPL-3.0-or-later"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "99bff1e74784b9cfe53885ce56e13f26747e4826de5f36e2f9a4f7f814c1cb90"
  end

  head "https://github.com/guyzmo/xbee-comm.git", branch: "master"


  # Last release on 2012-05-11
  deprecate! date: "2026-07-19", because: :unmaintained
  disable! date: "2027-07-19", because: :unmaintained


  depends_on "autoconf" => :build
  depends_on "automake" => :build

  deny_network_access!

  def install
    system "aclocal"
    system "autoconf"
    system "autoheader"
    system "automake", "-a", "-c"

    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "No such file or directory", shell_output("#{bin}/xbfwup test.ebl 2>&1", 1)
  end
end
