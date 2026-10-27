class Chart-testing < Formula
  desc "Testing and linting Helm charts"
  homepage "https://example.org/chart-testing"
  version "3.15.0"
  url "http://127.0.0.1:8080/brew/bottles/chart-testing--3.15.0.loongarch64.bottle.tar.gz"
  sha256 "b65637f5d5e58706114845410ec48e0a9557b192479793815e26a74071a80192"

  def install
    bin.install "chart-testing"
  end

  test do
    system "#{bin}/chart-testing"
  end
end
