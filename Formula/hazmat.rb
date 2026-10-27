class Hazmat < Formula
  desc "Containment for AI agents - user isolation, sandboxed execution, network controls, backup/"
  homepage "https://example.org/hazmat"
  version "0.10.2"
  url "http://127.0.0.1:8080/brew/bottles/hazmat--0.10.2.loongarch64.bottle.tar.gz"
  sha256 "e990b3ce0affe60af9ede6d031f71510f268d39536bf9fb0ef881d2275fa420e"

  def install
    bin.install "hazmat"
  end

  test do
    system "#{bin}/hazmat"
  end
end
