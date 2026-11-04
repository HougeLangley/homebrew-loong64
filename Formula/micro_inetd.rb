class MicroInetd < Formula
  desc "Simple network service spawner"
  homepage "https://web.archive.org/web/20241115023917/https://acme.com/software/micro_inetd/"
  url "https://pkg.freebsd.org/ports-distfiles/micro_inetd_14Aug2014.tar.gz"
  version "2014-08-14"
  sha256 "15f5558753bb50ed18e4a1445b3e8a185f3b1840ec8e017a5e6fc7690616ec52"
  license "BSD-2-Clause"


  # Original URLs are dead and last release from 2014-08-14
  deprecate! date: "2025-03-18", because: :unmaintained
  disable! date: "2026-03-18", because: :unmaintained

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "ef38752bfe6ac62ce2abba0d014ca49a94fdcacef624a58d708828cf1e214712"
  end

  def install
    bin.mkpath
    man1.mkpath
    system "make", "install", "BINDIR=#{bin}", "MANDIR=#{man1}"
  end

  test do
    port = free_port
    pid = spawn bin/"micro_inetd", port.to_s, "/bin/echo", "OK"

    # wait for server to be running
    sleep 1

    TCPSocket.open("localhost", port) do |sock|
      assert_equal "OK", sock.gets.strip
    end
  ensure
    Process.kill "TERM", pid
    Process.wait pid
  end
end
