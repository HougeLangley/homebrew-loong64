class Tcpdump < Formula
  desc "Command-line packet analyzer"
  homepage "https://www.tcpdump.org/"
  url "https://www.tcpdump.org/release/tcpdump-4.99.5.tar.gz"
  sha256 "8c75858e00b5c35a03406a0023bf240c43c4d2e25a65ec5e7f3d7a0a8e5914f9"
  license "BSD-3-Clause"

  depends_on "libpcap"
  depends_on "openssl@3"

  def install
    system "./configure",
           "--prefix=#{prefix}",
           "--disable-smb",
           "--disable-universal",
           "--with-crypto=#{Formula["openssl@3"].opt_prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"tcpdump", "--version"
  end
end
