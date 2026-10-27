class Claudie < Formula
  desc "Cloud-agnostic managed Kubernetes"
  homepage "https://example.org/claudie"
  version "0.16.3"
  url "http://127.0.0.1:8080/brew/bottles/claudie--0.16.3.loongarch64.bottle.tar.gz"
  sha256 "7d1dc1a687d3f7b7c9c7e68937d93eb5f06d9cb4c88c0bee178f166c9fe9acb2"

  def install
    bin.install "claudie"
  end

  test do
    system "#{bin}/claudie"
  end
end
