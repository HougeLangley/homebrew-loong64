class Velero < Formula
  desc "Backup and migrate Kubernetes applications and their persistent volumes"
  homepage "https://example.org/velero"
  version "1.18.4"
  url "http://127.0.0.1:8080/brew/bottles/velero--1.18.4.loongarch64.bottle.tar.gz"
  sha256 "b49cad987dfc72c94331fe953bbcd3d2382a4dbf920cfe764f9fd883a5e430ee"

  def install
    bin.install "velero"
  end

  test do
    system "#{bin}/velero"
  end
end
