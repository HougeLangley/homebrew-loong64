class Serving < Formula
  desc "Kubernetes-based, scale-to-zero, request-driven compute"
  homepage "https://example.org/serving"
  version "knative-v1.24.0"
  url "http://127.0.0.1:8080/brew/bottles/serving--knative-v1.24.0.loongarch64.bottle.tar.gz"
  sha256 "1944de78d5cfccdf605b8a5757b5a5a036026cb8f3f79ef3e171d3dbae25b17d"

  def install
    bin.install "serving"
  end

  test do
    system "#{bin}/serving"
  end
end
