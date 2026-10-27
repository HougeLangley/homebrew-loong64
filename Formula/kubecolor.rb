class Kubecolor < Formula
  desc "Colorize your kubectl output"
  homepage "https://example.org/kubecolor"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/kubecolor--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "ae104037411636bd653655d3dfa96c4b9dec0604e661e8721329540af97505d2"

  def install
    bin.install "kubecolor"
  end

  test do
    system "#{bin}/kubecolor"
  end
end
