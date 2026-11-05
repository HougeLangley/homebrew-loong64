class Sispmctl < Formula
  desc "Control Gembird SIS-PM programmable power outlet strips"
  homepage "https://sispmctl.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/sispmctl/sispmctl/sispmctl-4.12/sispmctl-4.12.tar.gz"
  sha256 "e757863a4838da6e1ca72a57adc5aca6fc47ffbddc72a69052d8abd743d57082"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "87a7f7f9a41dcdd2eccfda67762bf8d4f85d380614750063465d90a9a1071271"
  end



  depends_on "pkgconf" => :build
  depends_on "libusb-compat"

  def install
    system "./configure", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sispmctl -v 2>&1")
  end
end
