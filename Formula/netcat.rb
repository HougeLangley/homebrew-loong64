require "socket"

class Netcat < Formula
  desc "Utility for managing network connections"
  homepage "https://netcat.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/netcat/netcat/0.7.1/netcat-0.7.1.tar.bz2"
  sha256 "b55af0bbdf5acc02d1eb6ab18da2acd77a400bafd074489003f3df09676332bb"
  license "GPL-2.0-or-later"


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "df1ec6b11d4b9c6cd5a8057fbcc1bea93c00fb285b6dc2bd1951909315833f6c"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    # This old release explicitly requests external gettext, but also invokes
    # the removed AM_INTL_SUBDIR macro. Modern autoreconf rejects that macro;
    # retain its required locale detection without adding a bundled intl tree.
    inreplace "configure.ac", "AM_INTL_SUBDIR\n", "AC_CHECK_HEADERS([locale.h])\n"

    system "autoreconf", "--force", "--install", "--verbose"
    system "./configure", "--mandir=#{man}", "--infodir=#{info}", *std_configure_args
    system "make", "install"
    man1.install_symlink "netcat.1" => "nc.1"
  end

  test do
    server = TCPServer.new("127.0.0.1", 0)
    port = server.addr[1]
    responder = Thread.new do
      client = server.accept
      client.readpartial(4096)
      client.write "HTTP/1.0 200 OK\r\nContent-Length: 0\r\n\r\n"
      client.close
    end
    output = pipe_output("#{bin}/nc 127.0.0.1 #{port}", "GET / HTTP/1.0\r\n\r\n")
    responder.join
    server.close
    assert_equal "HTTP/1.0 200 OK", output.lines.first.chomp
  end
end
