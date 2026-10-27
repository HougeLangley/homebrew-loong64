class Kn < Formula
  desc "Command-line interface for managing Knative Serving and Eventing resources"
  homepage "https://example.org/kn"
  version "knative-v1.23.0"
  url "http://127.0.0.1:8080/brew/bottles/kn--knative-v1.23.0.loongarch64.bottle.tar.gz"
  sha256 "70b112534b57adab59d2f0376d033edbc362a92ed1864237dcd5ece7b0676255"

  def install
    bin.install "kn"
  end

  test do
    system "#{bin}/kn"
  end
end
