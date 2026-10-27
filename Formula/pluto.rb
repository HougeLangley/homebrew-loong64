class Pluto < Formula
  desc "CLI tool to help discover deprecated apiVersions in Kubernetes"
  homepage "https://example.org/pluto"
  version "5.24.4"
  url "http://127.0.0.1:8080/brew/bottles/pluto--5.24.4.loongarch64.bottle.tar.gz"
  sha256 "406eba3632c676155de150e7b3d03e593cf4e4271da63f2179b1c822942935d8"

  def install
    bin.install "pluto"
  end

  test do
    system "#{bin}/pluto"
  end
end
