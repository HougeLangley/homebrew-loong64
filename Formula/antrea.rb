class Antrea < Formula
  desc "Kubernetes networking based on Open vSwitch"
  homepage "https://example.org/antrea"
  version "2.7.0"
  url "http://127.0.0.1:8080/brew/bottles/antrea--2.7.0.loongarch64.bottle.tar.gz"
  sha256 "6dc6cf2dc6fc2d6a63abe03dccf506bfccb38fd3f9b4024df9ce613ee769dd9f"

  def install
    bin.install "antrea"
  end

  test do
    system "#{bin}/antrea"
  end
end
