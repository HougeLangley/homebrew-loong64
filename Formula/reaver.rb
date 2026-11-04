class Reaver < Formula
  desc "Implements brute force attack to recover WPA/WPA2 passkeys"
  homepage "https://github.com/t6x/reaver-wps-fork-t6x"
  url "https://github.com/t6x/reaver-wps-fork-t6x/releases/download/v1.6.6/reaver-1.6.6.tar.xz"
  sha256 "e329a0da0b6dd888916046535ff86a6aa144644561937954e560bb1810ab6702"
  license "GPL-2.0-or-later"

  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "fc3f95f6ee537b334d3246bfc750d2e7e321113da02e56a144366ca5a2ec08f4"
  end



  depends_on "pixiewps"

  uses_from_macos "libpcap"
  uses_from_macos "sqlite"

  deny_network_access!

  def install
    # reported upstream in https://github.com/t6x/reaver-wps-fork-t6x/issues/195
    man1.install "docs/reaver.1"
    prefix.install_metafiles "docs"
    cd "src"
    system "./configure", *std_configure_args
    system "make"
    bin.mkpath
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/reaver -i test_interface -b 00:90:4C:C1:AC:21 -vv 2>&1", 1)
    assert_match "Failed to retrieve a MAC address for interface 'test_interface'!", output
  end
end
