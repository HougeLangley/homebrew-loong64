class Kustomizer < Formula
  desc "Package manager for distributing Kubernetes configuration as OCI artifacts"
  homepage "https://example.org/kustomizer"
  version "2.2.1"
  url "http://127.0.0.1:8080/brew/bottles/kustomizer--2.2.1.loongarch64.bottle.tar.gz"
  sha256 "b6e8117470aef3f0d465f08ee79ff677dd78340d8cf6991574a6f7d481615fb3"

  def install
    bin.install "kustomizer"
  end

  test do
    system "#{bin}/kustomizer"
  end
end
