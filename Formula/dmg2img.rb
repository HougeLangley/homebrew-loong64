class Dmg2img < Formula
  desc "Utilities for converting macOS DMG images"
  homepage "http://vu1tur.eu.org/tools/"
  url "https://cdn.netbsd.org/pub/pkgsrc/distfiles/dmg2img-1.6.7.tar.gz"
  mirror "http://vu1tur.eu.org/tools/dmg2img-1.6.7.tar.gz"
  sha256 "02aea6d05c5b810074913b954296ddffaa43497ed720ac0a671da4791ec4d018"
  # OpenSSL is only used in vfdecrypt so avoids incompatibility with GPL-2.0-only
  license all_of: [
    "GPL-2.0-only",
    "MIT", # vfdecrypt
  ]
  revision 2

  livecheck do
    url :homepage
    regex(/href=.*?dmg2img[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f2b139577814734f6b219813d727829ed7fa25d88e95804906ddcc3fadac45a4"
  end

  depends_on "openssl@4"

  uses_from_macos "bzip2"

  on_linux do
    depends_on "zlib-ng-compat"
  end

  # Patch for OpenSSL 3 compatibility
  patch :p0 do
    file "Patches/dmg2img/openssl-3.diff"
    type :unofficial
  end

  def install
    system "make"
    bin.install "dmg2img"
    bin.install "vfdecrypt"
  end

  test do
    assert_match version.to_s, shell_output(bin/"dmg2img")
    output = shell_output("#{bin}/vfdecrypt 2>&1", 1)
    assert_match "No Passphrase given.", output
  end
end
