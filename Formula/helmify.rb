class Helmify < Formula
  desc "Create Helm chart from Kubernetes yaml"
  homepage "https://example.org/helmify"
  version "0.4.20"
  url "http://127.0.0.1:8080/brew/bottles/helmify--0.4.20.loongarch64.bottle.tar.gz"
  sha256 "1f449005c4bac24643ccdf273d6d3d23a1955143d5fd9f6d21f19a866d38792e"

  def install
    bin.install "helmify"
  end

  test do
    system "#{bin}/helmify"
  end
end
