class Httpflow < Formula
  desc "Packet capture and analysis utility similar to tcpdump for HTTP"
  homepage "https://github.com/six-ddc/httpflow"
  url "https://github.com/six-ddc/httpflow/archive/refs/tags/0.0.9.tar.gz"
  sha256 "2347bd416641e165669bf1362107499d0bc4524ed9bfbb273ccd3b3dd411e89c"
  license "MIT"
  head "https://github.com/six-ddc/httpflow.git", branch: "master"


  # Last release on 2020-05-07 and needs EOL `pcre` (https://github.com/six-ddc/httpflow/issues/12)
  deprecate! date: "2026-01-10", because: :unmaintained
  disable! date: "2027-01-10", because: :unmaintained

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "30887e3d6015731fabff9af9cf0cee8a27ec951934cce1f640a593d375cc98b5"
  end

  depends_on "pcre"

  uses_from_macos "libpcap"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}", "CXX=#{ENV.cxx}"
  end

  test do
    system bin/"httpflow", "-h"
  end
end
