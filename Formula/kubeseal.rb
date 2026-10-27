class Kubeseal < Formula
  desc "Kubernetes controller and tool for one-way encrypted Secrets"
  homepage "https://example.org/kubeseal"
  version "0.41.2"
  url "http://127.0.0.1:8080/brew/bottles/kubeseal--0.41.2.loongarch64.bottle.tar.gz"
  sha256 "4acea13c071dee9ff2f9ae1fa98be8a8e704323ff418e3ef3bbe1b5961e0f015"

  def install
    bin.install "kubeseal"
  end

  test do
    system "#{bin}/kubeseal"
  end
end
