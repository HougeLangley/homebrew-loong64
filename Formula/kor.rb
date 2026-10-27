class Kor < Formula
  desc "CLI tool to discover unused Kubernetes resources"
  homepage "https://example.org/kor"
  version "kor-0.2.16"
  url "http://127.0.0.1:8080/brew/bottles/kor--kor-0.2.16.loongarch64.bottle.tar.gz"
  sha256 "bef679ce6142660bafe495c0fb793773ac3e900888c584237a7178bc5904bcdf"

  def install
    bin.install "kor"
  end

  test do
    system "#{bin}/kor"
  end
end
