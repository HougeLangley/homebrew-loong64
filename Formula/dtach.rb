class Dtach < Formula
  desc "Emulates the detach feature of screen"
  homepage "https://dtach.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/dtach/dtach/0.9/dtach-0.9.tar.gz"
  sha256 "32e9fd6923c553c443fab4ec9c1f95d83fa47b771e6e1dafb018c567291492f3"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "2301624d95cf1cde195b10f146bbc388a0e44252228467d8b2a22ddf62f55438"
  end

  def install
    # Includes <config.h> instead of "config.h", so "." needs to be in the include path.
    ENV.append "CFLAGS", "-I. -Wno-error=incompatible-pointer-types -Wno-error=implicit-function-declaration"

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make"
    bin.install "dtach"
    man1.install Utils::Gzip.compress("dtach.1")
  end

  test do
    system bin/"dtach", "--help"
  end
end
