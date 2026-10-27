class Heartbeat < Formula
  desc "Lightweight Shipper for Uptime Monitoring"
  homepage "https://example.org/heartbeat"
  version "9.5.5"
  url "http://127.0.0.1:8080/brew/bottles/heartbeat--9.5.5.loongarch64.bottle.tar.gz"
  sha256 "dce0e2f9df8c2db8f40a504131cc46148fa849e4305b0ff027abe18fdb2d493e"

  def install
    bin.install "heartbeat"
  end

  test do
    system "#{bin}/heartbeat"
  end
end
