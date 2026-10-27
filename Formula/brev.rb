class Brev < Formula
  desc "CLI tool for managing workspaces provided by brev.dev"
  homepage "https://example.org/brev"
  version "0.6.337"
  url "http://127.0.0.1:8080/brew/bottles/brev--0.6.337.loongarch64.bottle.tar.gz"
  sha256 "4587d3d2d6bc75f71ccf054e0008dc2deaf94fc19fd6a4e2d9f4d332a452c2fe"

  def install
    bin.install "brev"
  end

  test do
    system "#{bin}/brev"
  end
end
