class Cortex < Formula
  desc "A horizontally scalable, highly available, multi-tenant, long term Prometheus."
  homepage "https://example.org/cortex"
  version "1.21.1"
  url "http://127.0.0.1:8080/brew/bottles/cortex--1.21.1.loongarch64.bottle.tar.gz"
  sha256 "cc3f8c09fab8aceef187269df8126c9f4574264a69c052a340f066b747b9426d"

  def install
    bin.install "cortex"
  end

  test do
    system "#{bin}/cortex"
  end
end
