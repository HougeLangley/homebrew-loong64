class Keel < Formula
  desc "Kubernetes Operator to automate Helm, DaemonSet, StatefulSet & Deployment updates"
  homepage "https://example.org/keel"
  version "keel-v1.2.3"
  url "http://127.0.0.1:8080/brew/bottles/keel--keel-v1.2.3.loongarch64.bottle.tar.gz"
  sha256 "d27a3d376f207004379bfa30f858cc7282dadfa8078022ab8a6720e34cf5540d"

  def install
    bin.install "keel"
  end

  test do
    system "#{bin}/keel"
  end
end
