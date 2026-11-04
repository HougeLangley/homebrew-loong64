class DfuProgrammer < Formula
  desc "Device firmware update based USB programmer for Atmel chips"
  homepage "https://github.com/dfu-programmer/dfu-programmer"
  url "https://github.com/dfu-programmer/dfu-programmer/releases/download/v1.1.0/dfu-programmer-1.1.0.tar.gz"
  sha256 "844e469be559657bc52c9d9d03c30846acd11ffbb1ddd42438fa8af1d2b8587d"
  license "GPL-2.0-or-later"


  head do
    url "https://github.com/dfu-programmer/dfu-programmer.git", branch: "master"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ed4ccb0193b941a898b1190b5279b777c5ad8f3c6601a0d9c28898215ee8c763"
  end

  depends_on "libusb"

  deny_network_access!

  def install
    system "./bootstrap.sh" if build.head?
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make", "install"
  end

  test do
    assert_match "8051 based controllers", shell_output("#{bin}/dfu-programmer --targets")
    assert_match version.to_s, shell_output("#{bin}/dfu-programmer --version 2>&1")
  end
end
