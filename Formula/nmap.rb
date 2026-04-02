class Nmap < Formula
  desc "Port scanning utility for large networks"
  homepage "https://nmap.org/"
  url "https://nmap.org/dist/nmap-7.95.tar.bz2"
  sha256 "e14ab530e47b5afd88f1c8a2bac7f89cd8fe6b478e22d19c5b04b54b1b5a2b2f"
  license "GPL-2.0-only"

  depends_on "liblinear"
  depends_on "libssh2"
  depends_on "lua"
  depends_on "openssl@3"
  depends_on "pcre2"
  depends_on "zlib-ng-compat"

  uses_from_macos "bison", since: :catalina
  uses_from_macos "flex", since: :catalina

  def install
    ENV.deparallelize
    
    args = %W[
      --prefix=#{prefix}
      --with-liblua=#{Formula["lua"].opt_prefix}
      --with-libpcre=#{Formula["pcre2"].opt_prefix}
      --with-openssl=#{Formula["openssl@3"].opt_prefix}
      --without-nmap-update
      --disable-universal
      --without-zenmap
    ]
    
    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"nmap", "--version"
  end
end
