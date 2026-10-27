class Chaoskube < Formula
  desc "Periodically kills random pods in your Kubernetes cluster"
  homepage "https://example.org/chaoskube"
  version "0.39.1"
  url "http://127.0.0.1:8080/brew/bottles/chaoskube--0.39.1.loongarch64.bottle.tar.gz"
  sha256 "e54895680cf891368a61d53780468050f32231644455fafbf6c36a4b5c487f58"

  def install
    bin.install "chaoskube"
  end

  test do
    system "#{bin}/chaoskube"
  end
end
