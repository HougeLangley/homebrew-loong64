class Cloudtty < Formula
  desc "A Friendly Kubernetes CloudShell (Web Terminal) ! "
  homepage "https://example.org/cloudtty"
  version "cloudtty-0.8.10"
  url "http://127.0.0.1:8080/brew/bottles/cloudtty--cloudtty-0.8.10.loongarch64.bottle.tar.gz"
  sha256 "72c4de078ece69024122dc275abd072d77ac4054a3d44e0c734115bef7a10190"

  def install
    bin.install "cloudtty"
  end

  test do
    system "#{bin}/cloudtty"
  end
end
