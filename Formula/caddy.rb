class Caddy < Formula
  desc "Powerful, enterprise-ready, open source web server with automatic HTTPS"
  homepage "https://caddyserver.com/"
  url "https://github.com/caddyserver/caddy/archive/refs/tags/v2.11.2.tar.gz"
  sha256 "5fdd706c53e8268a994569d658145fe9fa0765231d255e2a7733c88e0b27e718"
  license "Apache-2.0"
  head "https://github.com/caddyserver/caddy.git", branch: "master"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/caddy"
  end

  service do
    run [opt_bin/"caddy", "run", "--config", etc/"Caddyfile"]
    keep_alive true
    error_log_path var/"log/caddy.log"
    log_path var/"log/caddy.log"
  end

  test do
    system bin/"caddy", "version"
  end
end
