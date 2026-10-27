class Osmedeus < Formula
  desc "A Modern Orchestration Engine for Security"
  homepage "https://example.org/osmedeus"
  version "5.1.2"
  url "http://127.0.0.1:8080/brew/bottles/osmedeus--5.1.2.loongarch64.bottle.tar.gz"
  sha256 "30c10537110ce27763f71118730863b83a4dec5bd03626597c7f5f3be130d47a"

  def install
    bin.install "osmedeus"
  end

  test do
    system "#{bin}/osmedeus"
  end
end
