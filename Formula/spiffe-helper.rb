class Spiffe-helper < Formula
  desc "Tool that can be used to retrieve and manage SVIDs on behalf of a workload"
  homepage "https://example.org/spiffe-helper"
  version "0.12.2"
  url "http://127.0.0.1:8080/brew/bottles/spiffe-helper--0.12.2.loongarch64.bottle.tar.gz"
  sha256 "6d8fb7ec3fa74b92556f0472e73785b6fc790a933d3fecf3dbc44e61db258155"

  def install
    bin.install "spiffe-helper"
  end

  test do
    system "#{bin}/spiffe-helper"
  end
end
