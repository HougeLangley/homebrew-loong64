class Containerssh < Formula
  desc "ContainerSSH: Launch containers on demand"
  homepage "https://example.org/containerssh"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/containerssh--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "b93fd8370a1225062e04795134d0e4dd2fddf55770bb88a2c90d15d5ee210e4b"

  def install
    bin.install "containerssh"
  end

  test do
    system "#{bin}/containerssh"
  end
end
