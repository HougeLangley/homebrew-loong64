class Avce00 < Formula
  desc "Make Arc/Info (binary) Vector Coverages appear as E00"
  homepage "http://avce00.maptools.org/avce00/index.html"
  # Upstream is only available via HTTP, so we prefer Debian's HTTPS mirror
  url "https://deb.debian.org/debian/pool/main/a/avce00/avce00_2.0.0.orig.tar.gz"
  mirror "http://avce00.maptools.org/dl/avce00-2.0.0.tar.gz"
  sha256 "c0851f86b4cd414d6150a04820491024fb6248b52ca5c7bd1ca3d2a0f9946a40"
  license "MIT"


  # Last release on 2006-08-17
  deprecate! date: "2026-07-17", because: :unmaintained
  disable! date: "2027-01-17", because: :unmaintained

  conflicts_with "gdal", because: "both install a cpl_conv.h header"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "4cc3bd51954e424eff7d1db74d26b855bb055d94848ca056ead9c79dacb4e9eb"
  end

  def install
    system "make", "CC=#{ENV.cc}"
    bin.install "avcimport", "avcexport", "avcdelete", "avctest"
    lib.install "avc.a"
    include.install Dir["*.h"]
  end

  test do
    touch testpath/"test"
    system bin/"avctest", "-b", "test"
  end
end
