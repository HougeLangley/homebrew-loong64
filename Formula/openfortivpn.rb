class Openfortivpn < Formula
  desc "Open Fortinet client for PPP+TLS VPN tunnel services"
  homepage "https://github.com/adrienverge/openfortivpn"
  url "https://github.com/adrienverge/openfortivpn/archive/refs/tags/v1.24.1.tar.gz"
  sha256 "c40d33acd97b89c2e943bfd839c19b69e5a7a5997052e2fc9a595602745c0465"
  license "GPL-3.0-or-later" => { with: "cryptsetup-OpenSSL-exception" }
  revision 1
  head "https://github.com/adrienverge/openfortivpn.git", branch: "master"


  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "d8b7257f34d8d1fce59ff8af7405b793d026db23174e0a33667ea943af5ca5a1"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"

  # awaiting formula creation
  # uses_from_macos "pppd"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-silent-rules",
                          "--enable-legacy-pppd", # only for pppd < 2.5.0
                          "--sysconfdir=#{etc}/openfortivpn",
                          *std_configure_args
    system "make", "install"
  end

  service do
    run [opt_bin/"openfortivpn", "-c", etc/"openfortivpn/openfortivpn/config"]
    keep_alive true
    require_root true
    log_path var/"log/openfortivpn.log"
    error_log_path var/"log/openfortivpn.log"
  end

  test do
    system bin/"openfortivpn", "--version"
  end
end
