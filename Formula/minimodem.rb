class Minimodem < Formula
  desc "General-purpose software audio FSK modem"
  homepage "http://www.whence.com/minimodem/"
  url "https://deb.debian.org/debian/pool/main/m/minimodem/minimodem_0.24.orig.tar.gz"
  mirror "http://www.whence.com/minimodem/minimodem-0.24.tar.gz"
  sha256 "f8cca4db8e3f284d67f843054d6bb4d88a3db5e77b26192410e41e9a06f4378e"
  license "GPL-3.0-or-later"

  livecheck do
    url :homepage
    regex(/href=.*?minimodem[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "336ed9e67a8d0432e32d6f62aa031c98ccdfda47f220ed869e92a181bac9e7ae"
  end

  depends_on "pkgconf" => :build
  depends_on "fftw"
  depends_on "libsndfile"
  depends_on "pulseaudio"

  def install
    system "./configure", "--without-alsa", *std_configure_args
    system "make", "install"
  end

  test do
    system bin/"minimodem", "--benchmarks"
  end
end
