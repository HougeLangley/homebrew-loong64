class Sslh < Formula
  desc "Forward connections based on first data packet sent by client"
  homepage "https://www.rutschle.net/tech/sslh.shtml"
  url "https://www.rutschle.net/tech/sslh/sslh-v2.3.1.tar.gz"
  sha256 "51a5516ec5cb01823633b4d8cacdeee4efa0c56ef620d1c996d4f52ca51a601b"
  license all_of: ["GPL-2.0-or-later", "BSD-2-Clause"]
  head "https://github.com/yrutschle/sslh.git", branch: "master"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "7a32a9d4bb85b087e2ad133229867974a097328bf0ab65e365cd796fe41b31c3"
  end


  depends_on "libconfig"
  depends_on "libev"
  depends_on "pcre2"

  allow_network_access! :test

  def install
    # 老包自带的 config.sub 不认 loongarch64，用系统版本替换
    %w[config.sub config.guess].each do |cf|
      [cf, "build-aux/#{cf}", "config/#{cf}", "support/#{cf}", "scripts/#{cf}"].each do |dest|
        src = "/usr/share/libtool/build-aux/#{cf}"
        cp src, dest if File.exist?(dest) && File.exist?(src)
      end
    end

    system "./configure", "--build=loongarch64-unknown-linux-gnu", *std_configure_args
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    listen_port = free_port
    target_port = free_port
    pid = spawn sbin/"sslh", "--http=localhost:#{target_port}", "--listen=localhost:#{listen_port}", "--foreground"

    fork do
      TCPServer.open(target_port) do |server|
        session = server.accept
        session.write "HTTP/1.1 200 OK\r\n\r\nHello world!"
        session.close
      end
    end

    sleep 1
    assert_equal "Hello world!", shell_output("curl -s http://localhost:#{listen_port}")
  ensure
    Process.kill "TERM", pid
    Process.wait pid
  end
end
