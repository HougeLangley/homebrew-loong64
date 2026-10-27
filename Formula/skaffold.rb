class Skaffold < Formula
  desc "Easy and Repeatable Kubernetes Development"
  homepage "https://example.org/skaffold"
  version "2.25.0"
  url "http://127.0.0.1:8080/brew/bottles/skaffold--2.25.0.loongarch64.bottle.tar.gz"
  sha256 "1637cf02313948d3aaa845c5d1279e49a5a00d7200e5b8aece4a82e3c08c4472"

  def install
    bin.install "skaffold"
  end

  test do
    system "#{bin}/skaffold"
  end
end
