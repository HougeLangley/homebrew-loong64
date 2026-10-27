class Kluctl < Formula
  desc "The missing glue to put together large Kubernetes deployments, composed of multiple smalle"
  homepage "https://example.org/kluctl"
  version "2.28.2"
  url "http://127.0.0.1:8080/brew/bottles/kluctl--2.28.2.loongarch64.bottle.tar.gz"
  sha256 "af39e04cefbf57967da239acd3dc4a9d563cc2dff2a7a88a4b55666b2f6129be"

  def install
    bin.install "kluctl"
  end

  test do
    system "#{bin}/kluctl"
  end
end
