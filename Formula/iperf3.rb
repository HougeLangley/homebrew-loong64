class Iperf3 < Formula
  desc "TCP, UDP, and SCTP bandwidth test tool"
  homepage "https://example.org/iperf3"
  version "3.22"
  url "http://127.0.0.1:8080/brew/bottles/iperf3--3.22.loongarch64.bottle.tar.gz"
  sha256 "c7b39b6a9c7d53f66d8eee54d1e0dba2a50b0fc49737160bd8d534568b702cad"

  def install
    bin.install "iperf3"
  end

  test do
    system "#{bin}/iperf3"
  end
end
