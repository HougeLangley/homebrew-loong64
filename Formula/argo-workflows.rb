class Argo-workflows < Formula
  desc "Workflow Engine for Kubernetes"
  homepage "https://example.org/argo-workflows"
  version "4.1.6"
  url "http://127.0.0.1:8080/brew/bottles/argo-workflows--4.1.6.loongarch64.bottle.tar.gz"
  sha256 "a50ed5fe9d7fa0ccd8175e152dc5dc7ef465de1a4bb12b34bc8324e9463f802e"

  def install
    bin.install "argo-workflows"
  end

  test do
    system "#{bin}/argo-workflows"
  end
end
