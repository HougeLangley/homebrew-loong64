class Syngit < Formula
  desc "Syngit - Kubernetes operator to push resources on a git repository and manage their lifecy"
  homepage "https://example.org/syngit"
  version "0.9.2"
  url "http://127.0.0.1:8080/brew/bottles/syngit--0.9.2.loongarch64.bottle.tar.gz"
  sha256 "55855b288cfd837b1555a4302e118bb1f67ea9fe76bb184d33323078d3ff0562"

  def install
    bin.install "syngit"
  end

  test do
    system "#{bin}/syngit"
  end
end
