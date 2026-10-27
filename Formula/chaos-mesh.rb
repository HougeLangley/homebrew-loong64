class Chaos-mesh < Formula
  desc "A Chaos Engineering Platform for Kubernetes."
  homepage "https://example.org/chaos-mesh"
  version "2.8.6"
  url "http://127.0.0.1:8080/brew/bottles/chaos-mesh--2.8.6.loongarch64.bottle.tar.gz"
  sha256 "b9d9f8d94ad6ed3e0890e0c9e87904f304cfcd51f921cb7ca275fee7d8fe8c01"

  def install
    bin.install "chaos-mesh"
  end

  test do
    system "#{bin}/chaos-mesh"
  end
end
