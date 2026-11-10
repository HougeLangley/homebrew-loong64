class Microsocks < Formula
  desc "Tiny, portable SOCKS5 server with very moderate resource usage"
  homepage "https://github.com/rofl0r/microsocks"
  url "https://github.com/rofl0r/microsocks/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "939d1851a18a4c03f3cc5c92ff7a50eaf045da7814764b4cb9e26921db15abc8"
  license "MIT"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "35a5923ae6fb1c47f85ab8117cd056e4ba0c49efbcb03ecb7214f8859b2d0373"
  end

  head "https://github.com/rofl0r/microsocks.git", branch: "master"

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    require "socket"

    server = TCPServer.new("127.0.0.1", 0)
    http_port = server.addr[1]
    body = "microsocks-loopback-ok\n"
    responder = Thread.new do
      client = server.accept
      begin
        while (line = client.gets)
          break if line == "\r\n"
        end
        client.write "HTTP/1.1 200 OK\r\nContent-Length: #{body.bytesize}\r\nConnection: close\r\n\r\n#{body}"
      ensure
        client.close
      end
    end

    socks_port = free_port
    socks_pid = spawn bin/"microsocks", "-p", socks_port.to_s
    begin
      sleep 2
      output = shell_output("curl --noproxy \"\" --fail --silent --show-error " \
                            "--socks5 127.0.0.1:#{socks_port} http://127.0.0.1:#{http_port}/")
      assert_equal body, output
    ensure
      Process.kill("TERM", socks_pid)
      begin
        Process.wait(socks_pid)
      rescue Errno::ECHILD
      end
      responder.kill
      responder.join
      server.close
    end
  end
end
