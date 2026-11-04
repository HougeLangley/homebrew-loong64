class EmsFlasher < Formula
  desc "Software for flashing the EMS Gameboy USB cart"
  homepage "https://lacklustre.net/projects/ems-flasher/"
  url "https://lacklustre.net/projects/ems-flasher/ems-flasher-0.03.tgz"
  sha256 "d77723a3956e00a9b8af9a3545ed2c55cd2653d65137e91b38523f7805316786"
  license "MIT"

  livecheck do
    url :homepage
    regex(/href=.*?ems-flasher[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "657236e447bce2130341f49e5b91edf54c1e6ed1e6f5c548afdf9684faeb557c"
  end

  depends_on "pkgconf" => :build
  depends_on "libusb"

  def install
    system "make"
    bin.install "ems-flasher"
  end

  test do
    system bin/"ems-flasher", "--version"
  end
end
