class Agent-sandbox < Formula
  desc "agent-sandbox enables easy management of isolated, stateful, singleton workloads, ideal fo"
  homepage "https://example.org/agent-sandbox"
  version "1.0.8"
  url "http://127.0.0.1:8080/brew/bottles/agent-sandbox--1.0.8.loongarch64.bottle.tar.gz"
  sha256 "0b75fb1e2a8c40c56c097e2ea211c610957d9b123e69b55fe99df6d93cc34bc2"

  def install
    bin.install "agent-sandbox"
  end

  test do
    system "#{bin}/agent-sandbox"
  end
end
