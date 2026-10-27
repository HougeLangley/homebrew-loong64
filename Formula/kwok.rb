class Kwok < Formula
  desc "Kubernetes WithOut Kubelet -  Simulates thousands of Nodes and Clusters."
  homepage "https://example.org/kwok"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/kwok--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "e783ca3d810dd9a5beca4721a6cf117526be7b57d1e9401c92e1723c0fe68fe7"

  def install
    bin.install "kwok"
  end

  test do
    system "#{bin}/kwok"
  end
end
