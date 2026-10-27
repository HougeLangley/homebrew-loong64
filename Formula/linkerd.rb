class Linkerd < Formula
  desc "Command-line utility to interact with linkerd"
  homepage "https://example.org/linkerd"
  version "edge-26.10.1"
  url "http://127.0.0.1:8080/brew/bottles/linkerd--edge-26.10.1.loongarch64.bottle.tar.gz"
  sha256 "7b68b31336f21234b9ee4f452eec8d8223c7b93d05c7670e658ab0a91729e963"

  def install
    bin.install "linkerd"
  end

  test do
    system "#{bin}/linkerd"
  end
end
