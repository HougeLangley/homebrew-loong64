class SomagicTools < Formula
  desc "Tools to extract firmware from EasyCAP"
  homepage "https://code.google.com/archive/p/easycap-somagic-linux/"
  url "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/easycap-somagic-linux/somagic-easycap-tools_1.1.tar.gz"
  sha256 "b091723c55e6910cbf36c88f8d37a8d69856868691899683ec70c83b122a0715"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "408736cf1ccf430e97e986ed95f3fe5abec663cc0c2c6e720aceb33d1a702907"
  end



  depends_on "libgcrypt"
  depends_on "libusb"

  deny_network_access!

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    # requires actual firmware to function
    assert_match version.to_s, shell_output("#{bin}/somagic-extract-firmware --version 2>&1")
  end
end
