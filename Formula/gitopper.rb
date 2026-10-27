class Gitopper < Formula
  desc "Gitops for non-Kubernetes folks"
  homepage "https://example.org/gitopper"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/gitopper--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "71aa786faaa2d0aad272e2a435d399dfd6207b6e792f327f1679fd36b206fcfc"

  def install
    bin.install "gitopper"
  end

  test do
    system "#{bin}/gitopper"
  end
end
