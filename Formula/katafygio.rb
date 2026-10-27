class Katafygio < Formula
  desc "Dump, or continuously backup Kubernetes objets as yaml files in git"
  homepage "https://example.org/katafygio"
  version "0.8.3"
  url "http://127.0.0.1:8080/brew/bottles/katafygio--0.8.3.loongarch64.bottle.tar.gz"
  sha256 "4cad700f534b00ba8097c6032f040da662f15df52ec4b61f8e07bb52396f3e50"

  def install
    bin.install "katafygio"
  end

  test do
    system "#{bin}/katafygio"
  end
end
