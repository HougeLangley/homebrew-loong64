class Kubectl-explore < Formula
  desc "Better kubectl explain with the fuzzy finder"
  homepage "https://example.org/kubectl-explore"
  version "0.14.1"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-explore--0.14.1.loongarch64.bottle.tar.gz"
  sha256 "14294d4e0613af2d863c732804cdcabb2e9e2928eebf756dd3f2be68f14e3a28"

  def install
    bin.install "kubectl-explore"
  end

  test do
    system "#{bin}/kubectl-explore"
  end
end
