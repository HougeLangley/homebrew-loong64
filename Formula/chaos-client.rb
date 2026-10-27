class Chaos-client < Formula
  desc "Client to communicate with Chaos DB API"
  homepage "https://example.org/chaos-client"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/chaos-client--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "f9671dd745e39b0a4712dc853f0a483460154b96a4494a2ea7daa08a673b1e4f"

  def install
    bin.install "chaos-client"
  end

  test do
    system "#{bin}/chaos-client"
  end
end
