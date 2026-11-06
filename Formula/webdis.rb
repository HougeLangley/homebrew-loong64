class Webdis < Formula
  desc "Redis HTTP interface with JSON output"
  homepage "https://webd.is/"
  url "https://github.com/nicolasff/webdis/archive/refs/tags/0.1.25.tar.gz"
  sha256 "60dc5e876a1df74d83ce5db41f99c61e62f45fa5ea7dbfedde4b1c99530f8032"
  license "BSD-2-Clause"



  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "bde276f8586c7fbf90c3dc18a200035e0d91ab2a23ae90c98569730bb648e96e"
  end

  depends_on "libevent"

  allow_network_access! :test

  def install
    system "make"
    bin.install "webdis"

    inreplace "webdis.prod.json" do |s|
      s.gsub! "/var/log/webdis.log", "#{var}/log/webdis.log"
      s.gsub!(/daemonize":\s*true/, "daemonize\":\tfalse")
    end

    etc.install "webdis.json", "webdis.prod.json"
    (var/"log").mkpath
  end

  service do
    run [opt_bin/"webdis", etc/"webdis.prod.json"]
    keep_alive true
    working_dir var
  end

  test do
    port = free_port
    cp etc/"webdis.json", testpath/"webdis.json"
    inreplace "webdis.json", "7379", port.to_s

    server = spawn bin/"webdis", "webdis.json"
    sleep 2
    # Test that the response is from webdis
    assert_match(/Server: Webdis/, shell_output("curl --silent -XGET -I http://localhost:#{port}/PING"))
  ensure
    Process.kill "TERM", server
    Process.wait server
  end
end
