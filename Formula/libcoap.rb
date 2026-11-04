class Libcoap < Formula
  desc "Lightweight application-protocol for resource-constrained devices"
  homepage "https://github.com/obgm/libcoap"
  url "https://github.com/obgm/libcoap/archive/refs/tags/v4.3.5b.tar.gz"
  version "4.3.5b"
  sha256 "383a17d8466cee7c1cb1d4dfbffad2651004850b29eb590e9591c7bedd46741d"
  license "BSD-2-Clause"


  bottle do
    rebuild 2
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "7f45cda7fec5290ae3e6ad4ed70d3740af61dfac472f6a85f148303fcef9045e"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkgconf" => :build
  depends_on "openssl@4"

  # Backport support for OpenSSL 4
  patch do
    url "https://github.com/obgm/libcoap/commit/83ceb9687cfcc3c4683e8b1423ac00ba01c5be3c.patch?full_index=1"
    sha256 "4d22e9267fe8fe8d23424df1ec1fac1ccfffd50d07010d2f459402feb71abcdf"
    type :backport
  end
  patch do
    url "https://github.com/obgm/libcoap/commit/5ea8b7d5e956d1574d78115da007bf23d118f1ae.patch?full_index=1"
    sha256 "58f7d528e62c7a887201f7c47ae91dbe8b09b0f5cdc5a26fb3c685bb4815ea69"
    type :backport
    resolves "https://github.com/obgm/libcoap/pull/2048"
  end

  allow_network_access! :test

  def install
    system "./autogen.sh"
    system "./configure", "--disable-manpages", "--disable-doxygen", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    port = free_port
    spawn bin/"coap-server", "-p", port.to_s
    sleep 1
    output = shell_output("#{bin}/coap-client -B 5 -m get coap://localhost:#{port}")
    assert_match "This is a test server made with libcoap", output
  end
end
