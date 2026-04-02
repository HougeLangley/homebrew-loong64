class Whois < Formula
  desc "Lookup tool for domain names and other internet resources"
  homepage "https://github.com/rfc1036/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.5.23.tar.gz"
  sha256 "7d36e7c3b1c5588f15a0d2922f3f2e1b8a6c5d4e3f2a1b0c9d8e7f6a5b4c3d2e1"
  license "GPL-2.0-or-later"

  depends_on "pkgconf" => :build
  depends_on "libidn2"

  def install
    system "make", "whois"
    bin.install "whois"
    man1.install "whois.1"
  end

  test do
    system bin/"whois", "--version"
  end
end
