class Openhmd < Formula
  desc "Free and open source API and drivers for immersive technology"
  homepage "http://openhmd.net"
  url "https://github.com/OpenHMD/OpenHMD/archive/refs/tags/0.3.0.tar.gz"
  sha256 "ec5c97ab456046a8aef3cde6d59e474603af398f1d064a66e364fe3c0b26a0fa"
  license "BSL-1.0"
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "f3062e291851a9789c4e9270360a0f84f63e86d2d8f208af512dca5cce62fd98"
  end

  head "https://github.com/OpenHMD/OpenHMD.git", branch: "master"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "hidapi"

  conflicts_with "cspice", because: "both install `simple` binaries"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
    (pkgshare/"tests").install bin/"unittests"
  end

  test do
    system pkgshare/"tests/unittests"
  end
end
