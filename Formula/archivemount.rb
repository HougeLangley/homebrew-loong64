class Archivemount < Formula
  desc "File system for accessing archives using libarchive"
  homepage "https://git.sr.ht/~nabijaczleweli/archivemount-ng"
  url "https://git.sr.ht/~nabijaczleweli/archivemount-ng/archive/1c.tar.gz"
  version "1c"
  sha256 "7bc489a1a77ce718c84b751a57779ded6bb192cf54f9cd0bf7bff2527cf98bfc"
  license "LGPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "772263040fcd469f408497728905701963a5350abd56746b82730293affb73ec"
  end

  depends_on "pkgconf" => :build
  depends_on "libarchive"
  depends_on "libfuse"
  depends_on :linux # on macOS, requires closed-source macFUSE

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system bin/"archivemount", "--version"
  end
end
