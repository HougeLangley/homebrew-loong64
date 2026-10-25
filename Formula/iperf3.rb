class Iperf3 < Formula
  desc "TCP, UDP, and SCTP bandwidth test tool"
  homepage "https://example.org/iperf3"
  version "3.22"
  url "http://127.0.0.1:8080/brew/bottles/iperf3--3.22.loongarch64.bottle.tar.gz"
  sha256 "fcc6b7978659fcb4059e7e961c6d1ada1b6fa799b0c98d726207da6df92d7309"

  def install
    bin.install "iperf3"
  end

  test do
    system "#{bin}/iperf3"
  end
end
