class Nfcutils < Formula
  desc "Near Field Communication (NFC) tools under POSIX systems"
  homepage "https://github.com/nfc-tools/nfcutils"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/nfc-tools/nfcutils-0.3.2.tar.gz"
  sha256 "dea258774bd08c8b7ff65e9bed2a449b24ed8736326b1bb83610248e697c7f1b"
  license "GPL-3.0-or-later"
  revision 1


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "20259abdb8cf27e55137323489687d622e529ac199de34c2ba4e8837cffb3b0b"
  end

  depends_on "pkgconf" => :build
  depends_on "libnfc"
  depends_on "libusb"

  on_macos do
    depends_on "libusb-compat"
  end

  deny_network_access!

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    ENV["LIBNFC_AUTO_SCAN"] = "false"
    assert_equal "ERROR: No device found.", shell_output(bin/"lsnfc").strip

    ENV["LIBNFC_DEVICE"] = "pn532_uart:#{testpath}/nonexistent"
    assert_equal "ERROR: Unable to connect to NFC device.", shell_output(bin/"lsnfc", 1).strip
  end
end
