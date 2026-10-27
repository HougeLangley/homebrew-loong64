class Chain-bench < Formula
  desc "Software supply chain auditing tool based on CIS benchmark"
  homepage "https://example.org/chain-bench"
  version "0.1.10"
  url "http://127.0.0.1:8080/brew/bottles/chain-bench--0.1.10.loongarch64.bottle.tar.gz"
  sha256 "71c7e9b0969edceaf0197be9ad48c58f66bc751a45cfde816c35bdd579d3616e"

  def install
    bin.install "chain-bench"
  end

  test do
    system "#{bin}/chain-bench"
  end
end
