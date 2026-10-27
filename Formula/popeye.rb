class Popeye < Formula
  desc "Kubernetes cluster resource sanitizer"
  homepage "https://example.org/popeye"
  version "0.22.1"
  url "http://127.0.0.1:8080/brew/bottles/popeye--0.22.1.loongarch64.bottle.tar.gz"
  sha256 "9ffcc0c899cf32b1551de94589fe035d8c76d23263ccf7bbf28ea1be3207d3f4"

  def install
    bin.install "popeye"
  end

  test do
    system "#{bin}/popeye"
  end
end
