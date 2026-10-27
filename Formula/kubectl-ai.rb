class Kubectl-ai < Formula
  desc "AI powered Kubernetes Assistant"
  homepage "https://example.org/kubectl-ai"
  version "0.0.31"
  url "http://127.0.0.1:8080/brew/bottles/kubectl-ai--0.0.31.loongarch64.bottle.tar.gz"
  sha256 "04c002e98cfcb060f232590de044323338361cede994b28ada495e67e3a9ad0a"

  def install
    bin.install "kubectl-ai"
  end

  test do
    system "#{bin}/kubectl-ai"
  end
end
