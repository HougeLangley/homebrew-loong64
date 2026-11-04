class Bozohttpd < Formula
  desc "Small and secure http version 1.1 server"
  homepage "https://pkgsrc.se/www/bozohttpd"
  url "https://cdn.netbsd.org/pub/pkgsrc/distfiles/LOCAL_PORTS/bozohttpd-20260503.tar.bz2"
  sha256 "2a2e6d62b68d219434973937a8febd17741f22e98c741f6c922b22f13f7523cd"
  license "BSD-2-Clause"

  livecheck do
    url "https://cdn.netbsd.org/pub/pkgsrc/distfiles/"
    regex(/href=.*?bozohttpd[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "aef5a8a2240b81c737066bbcf091089d5cfdbb924d63ed4648428662826ac900"
  end

  depends_on "openssl@4"

  allow_network_access! :test

  def install
    system "make", "-f", "Makefile.boot", "CC=#{ENV.cc}"
    bin.install "bozohttpd"
  end

  test do
    port = free_port

    expected_output = "Hello from bozotic httpd!"
    (testpath/"index.html").write expected_output

    spawn bin/"bozohttpd", "-b", "-f", "-I", port.to_s, testpath
    assert_match expected_output, shell_output("curl --silent --retry 5 --retry-connrefused 127.0.0.1:#{port}")
  end
end
