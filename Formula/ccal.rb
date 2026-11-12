class Ccal < Formula
  desc "Create Chinese calendars for print or browsing"
  homepage "https://ccal.chinesebay.com/ccal/ccal.htm"
  # Original host fails during TLS; this historical mirror matches the original SHA-256.
  url "https://ftp.belnet.be/mirrors/salixos.org/i486/extra-14.2/source/office/ccal/ccal-2.5.3.tar.gz"
  sha256 "3d4cbdc9f905ce02ab484041fbbf7f0b7a319ae6a350c6c16d636e1a5a50df96"
  license "GPL-2.0-or-later"


  # Upstream homepage is gone
  deprecate! date: "2026-06-22", because: :does_not_build
  disable! date: "2026-12-22", because: :does_not_build

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "20dc7b6d28973b1cf4f3df55b24c93605341161c362b733eb6fd4d78329c7e8d"
  end

  def install
    system "make", "-e", "BINDIR=#{bin}", "install"
    system "make", "-e", "MANDIR=#{man}", "install-man"
  end

  test do
    assert_match "Year JiaWu, Month 1X", shell_output("#{bin}/ccal 2 2014")
  end
end
