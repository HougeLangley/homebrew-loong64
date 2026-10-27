class Pulse < Formula
  desc "Real-time monitoring dashboard for Proxmox VE, PBS, Docker, Kubernetes, TrueNAS and vSpher"
  homepage "https://example.org/pulse"
  version "6.6.0"
  url "http://127.0.0.1:8080/brew/bottles/pulse--6.6.0.loongarch64.bottle.tar.gz"
  sha256 "38b346beb69c7956e9d28e7496fc60ca9fd599ff2c4a4431f665893fc2ddfb43"

  def install
    bin.install "pulse"
  end

  test do
    system "#{bin}/pulse"
  end
end
