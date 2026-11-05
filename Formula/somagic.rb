class Somagic < Formula
  desc "Linux capture program for the Somagic variants of EasyCAP"
  homepage "https://code.google.com/archive/p/easycap-somagic-linux/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/easycap-somagic-linux/somagic-easycap_1.1.tar.gz"
  sha256 "3a9dd78a47335a6d041cd5465d28124612dad97939c56d7c10e000484d78a320"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "0c43955827857ccbf8a88f1e26e65f507e45886a2c6e0b958f24fa68bcd28c8f"
  end



  depends_on "libgcrypt"
  depends_on "libusb"
  depends_on "somagic-tools"

  deny_network_access!

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  def caveats
    <<~EOS
      Before running somagic-capture you must extract the official firmware from the CD.
      See https://code.google.com/archive/p/easycap-somagic-linux/wikis/GettingStarted.wiki for details.
    EOS
  end

  test do
    (testpath/"bad.bin").write "not a firmware image"
    output = shell_output("#{bin}/somagic-init -f #{testpath}/bad.bin 2>&1", 1)
    assert_match "Firmware file '#{testpath}/bad.bin' was not recognized", output

    # 6634-byte image whose CRC32 matches the EasyCAP002 firmware
    firmware = ["0c94cc00"].pack("H*") + ("\0" * 6626) + ["d96890a3"].pack("H*")
    (testpath/"firmware.bin").binwrite firmware

    # libusb cannot be initialised without usbfs in Linux containers
    return unless OS.mac?

    output = shell_output("#{bin}/somagic-init -f #{testpath}/firmware.bin 2>&1", 1)
    assert_match "USB device 1c88:0007 was not found. Is the device attached?", output
  end
end
