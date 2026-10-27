class Cloud-nuke < Formula
  desc "CLI tool to nuke (delete) cloud resources"
  homepage "https://example.org/cloud-nuke"
  version "0.53.0"
  url "http://127.0.0.1:8080/brew/bottles/cloud-nuke--0.53.0.loongarch64.bottle.tar.gz"
  sha256 "eeca17999806e859cb3d9a6163f87b7864529ee7c036b379510aca2690a9876a"

  def install
    bin.install "cloud-nuke"
  end

  test do
    system "#{bin}/cloud-nuke"
  end
end
