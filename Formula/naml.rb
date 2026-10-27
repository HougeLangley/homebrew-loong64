class Naml < Formula
  desc "Convert Kubernetes YAML to Golang"
  homepage "https://example.org/naml"
  version "1.0.3"
  url "http://127.0.0.1:8080/brew/bottles/naml--1.0.3.loongarch64.bottle.tar.gz"
  sha256 "cd4872186722b5d8b76abe8f041cdacf098f969234c0cd77e40bf5499d28df8f"

  def install
    bin.install "naml"
  end

  test do
    system "#{bin}/naml"
  end
end
