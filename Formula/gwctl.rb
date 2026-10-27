class Gwctl < Formula
  desc "CLI for managing and inspecting Gateway API resources in Kubernetes clusters"
  homepage "https://example.org/gwctl"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/gwctl--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "7769cbed74e34a8c021aff3a720f98f2af2395e66d580b522967c99c44e2d8d1"

  def install
    bin.install "gwctl"
  end

  test do
    system "#{bin}/gwctl"
  end
end
