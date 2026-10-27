class Kubectl-radar < Formula
  desc "Missing open-source Kubernetes UI with a built-in MCP server for AI agents"
  homepage "https://example.org/kubectl-radar"
  version "1.18.2"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-radar--1.18.2.loongarch64.bottle.tar.gz"
  sha256 "e6e34afbde359949e752ee595cf4b01dd5d7d93dc4bebd139d42b5824983dff1"

  def install
    bin.install "kubectl-radar"
  end

  test do
    system "#{bin}/kubectl-radar"
  end
end
