class Pciutils < Formula
  desc "PCI utilities"
  homepage "https://github.com/pciutils/pciutils"
  url "https://github.com/pciutils/pciutils/releases/download/v3.15.0/pciutils-3.15.0.tar.gz"
  sha256 "a42e6e3f76fb6b1f6ac2e08cdd151f6bf78bc4f6312c591f4b6ec197582ede3a"
  license "GPL-2.0-or-later"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "77df7c2e04c0def6d84fc05c0006c3579982c8ef13149acec56f70080fdb9d7e"
  end

  depends_on :linux # arm64 macOS is not supported: https://github.com/pciutils/pciutils/issues/111
  depends_on "zlib-ng-compat"

  def install
    args = ["ZLIB=yes", "DNS=yes", "SHARED=yes", "PREFIX=#{prefix}", "MANDIR=#{man}"]
    system "make", *args
    system "make", "install", *args
    system "make", "install-lib", *args
  end

  test do
    assert_match "lspci version", shell_output("#{bin}/lspci --version")
    assert_match(/Host bridge:|controller:/, shell_output("#{bin}/lspci"))
  end
end
