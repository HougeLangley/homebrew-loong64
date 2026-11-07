class Bootloadhid < Formula
  desc "HID-based USB bootloader for AVR microcontrollers"
  homepage "https://www.obdev.at/products/vusb/bootloadhid.html"
  url "https://www.obdev.at/downloads/vusb/bootloadHID.2012-12-08.tar.gz"
  sha256 "154e7e38629a3a2eec2df666edfa1ee2f2e9a57018f17d9f0f8f064cc20d8754"
  license any_of: ["GPL-2.0-only", "GPL-3.0-only"]

  livecheck do
    url :homepage
    regex(/href=.*?bootloadHID[._-]v?(\d{4}-\d{1,2}-\d{1,2})\.t/i)
  end



  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "15be8c0ec11c288856550ea49b7b33a3d426522561e386907279f7a7912c6ca9"
  end

  depends_on "libusb-compat"

  def install
    Dir.chdir "commandline"
    system "make"
    bin.install "bootloadHID"
  end

  test do
    touch "test.hex"
    assert_equal "No data in input file, exiting.", shell_output("#{bin}/bootloadHID -r test.hex 2>&1").strip
  end
end
