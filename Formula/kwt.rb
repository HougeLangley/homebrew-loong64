class Kwt < Formula
  desc "Kubernetes Workstation Tools CLI"
  homepage "https://example.org/kwt"
  version "0.0.8"
  url "http://127.0.0.1:8080/brew/bottles/kwt--0.0.8.loongarch64.bottle.tar.gz"
  sha256 "121687c6f2afcfe1d354d5c6b4139ecc58abfcffe0a562dd8670af42a05f27a6"

  def install
    bin.install "kwt"
  end

  test do
    system "#{bin}/kwt"
  end
end
