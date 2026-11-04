class Dpcmd < Formula
  desc "Linux software for DediProg SF100/SF600"
  homepage "https://github.com/DediProgSW/SF100Linux"
  url "https://github.com/DediProgSW/SF100Linux/archive/refs/tags/V1.14.21,x.tar.gz"
  sha256 "2bab3df0b971e66f574db33daa1687d1a064eed6b3e99d97c265bfce35470ddf"
  license "GPL-2.0-only"

  livecheck do
    url :stable
    strategy :github_latest
  end


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "fd877210a2e1a3ede0147acd7629002de10b7c90286f4a12a62a3ed5a1bd3535"
  end

  depends_on "pkgconf" => :build
  depends_on "libusb"

  def install
    system "make"
    bin.install "dpcmd"
    (share/"DediProg").install "ChipInfoDb.dedicfg"
  end

  test do
    # Try and read from a device that isn't connected
    assert_match version.to_s, shell_output("#{bin}/dpcmd -rSTDOUT -a0x100 -l0x23", 1)
  end
end
