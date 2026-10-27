class Kind < Formula
  desc "Kubernetes IN Docker - local clusters for testing Kubernetes"
  homepage "https://example.org/kind"
  version "0.33.0"
  url "http://127.0.0.1:8080/brew/bottles/kind--0.33.0.loongarch64.bottle.tar.gz"
  sha256 "3f502c4b012bc6dad68f1921024c0cdf5369005753e9848a22aec0807d39e804"

  def install
    bin.install "kind"
  end

  test do
    system "#{bin}/kind"
  end
end
