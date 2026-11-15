class Mfoc < Formula
  desc "Implementation of 'offline nested' attack by Nethemba"
  homepage "https://github.com/nfc-tools/mfoc"
  url "https://github.com/nfc-tools/mfoc/archive/refs/tags/mfoc-0.10.7.tar.gz"
  sha256 "2dfd8ffa4a8b357807680d190a91c8cf3db54b4211a781edc1108af401dbaad7"
  license all_of: [
    "GPL-2.0-or-later",
    "BSD-2-Clause", # src/nfc-utils.*; src/mifare.*
  ]
  revision 2
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7b0a51e5c1e7b608c9f4d80ff483e58bb6fa66e38e0784a2b2dfcf7bd60cfa9b"
  end

  head "https://github.com/nfc-tools/mfoc.git", branch: "master"



  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "libnfc"

  on_macos do
    depends_on "libusb-compat"
  end

  def install
    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "No NFC device found", shell_output("#{bin}/mfoc -O /dev/null", 1)
  end
end
