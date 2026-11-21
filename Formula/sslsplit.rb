class Sslsplit < Formula
  desc "Man-in-the-middle attacks against SSL encrypted network connections"
  homepage "https://www.roe.ch/SSLsplit"
  license "BSD-2-Clause"
  revision 3
  bottle do
    rebuild 1
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "885a5ad7d222b9d45c2d875ef2d224375624acf2f33376dfd6f41ad6a5ce3886"
  end

  head "https://github.com/droe/sslsplit.git", branch: "develop"

  stable do
    url "https://github.com/droe/sslsplit/archive/refs/tags/0.5.5.tar.gz"
    sha256 "3a6b9caa3552c9139ea5c9841d4bf24d47764f14b1b04b7aae7fa2697641080b"

    # Patch to add `openssl@3` support
    patch do
      url "https://github.com/droe/sslsplit/commit/e17de8454a65d2b9ba432856971405dfcf1e7522.patch?full_index=1"
      sha256 "88d558dcb21b1a23fe0b97f41251e7a321b11c37afd70dd07ac1a2d6a4788629"
      type :backport
      resolves "https://github.com/droe/sslsplit/issues/290"
    end
  end



  depends_on "check" => :build
  depends_on "pkgconf" => :build
  depends_on "libevent"
  depends_on "libnet"
  depends_on "libpcap"
  depends_on "openssl@4"

  # Apply Debian patch to support OpenSSL 4
  patch do
    url "https://salsa.debian.org/debian/sslsplit/-/raw/1a4c4507193f974bfdd9d08314b46226da592a50/debian/patches/0004-Compatibility-with-OpenSSL-4.patch"
    sha256 "ca8310d50822d5dda9ac559dc9d09ca473ab62c7f951375cf20ade20151539be"
    type :unofficial
    resolves "https://github.com/droe/sslsplit/issues/343"
  end

  allow_network_access! :test

  def install
    ENV["LIBNET_BASE"] = formula_opt_prefix("libnet")
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    Open3.popen2e(bin/"sslsplit", "-D", "http", "0.0.0.0", free_port.to_s, "www.roe.ch", "80") do |_, stdout, w|
      sleep 5
      assert_match "Starting main event loop", stdout.read_nonblock(4096)
    ensure
      Process.kill "TERM", w.pid
    end
  end
end
