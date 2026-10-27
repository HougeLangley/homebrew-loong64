class Process-compose < Formula
  desc "Process Compose is a simple and flexible scheduler and orchestrator to manage non-containe"
  homepage "https://example.org/process-compose"
  version "1.124.0"
  url "http://127.0.0.1:8080/brew/bottles/process-compose--1.124.0.loongarch64.bottle.tar.gz"
  sha256 "e0fdbf2834b469362832096af9bd211f4c00dfee4f7b9698a586616bdd782428"

  def install
    bin.install "process-compose"
  end

  test do
    system "#{bin}/process-compose"
  end
end
