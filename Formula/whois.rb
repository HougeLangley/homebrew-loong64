class Whois < Formula
  desc "Lookup tool for domain names and other internet resources"
  homepage "https://github.com/rfc1036/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.6.6.tar.gz"
  sha256 "43d3b3cc64c75e8bd10aee6feff3906e9488ed335076d206e70f3b25bf644969"
  license "GPL-2.0-or-later"
  head "https://github.com/rfc1036/whois.git", branch: "next"


  keg_only :provided_by_macos

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "65fca5efbca711ee2dc72040b56806b69a196df409df75c38107ee126226d4f4"
  end

  depends_on "pkgconf" => :build
  depends_on "libidn2"

  def install
    ENV.append "LDFLAGS", "-L/usr/lib -liconv" if OS.mac?

    # Workaround to expose strdup, https://github.com/rfc1036/whois/issues/171#issuecomment-4710871610
    ENV.append_to_cflags "-D_DARWIN_C_SOURCE" if OS.mac?

    system "make", "install-whois", "prefix=#{prefix}", "HAVE_ICONV=1"
  end

  test do
    system bin/"whois", "brew.sh"
  end
end
