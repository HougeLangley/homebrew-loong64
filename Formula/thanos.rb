class Thanos < Formula
  desc "Highly available Prometheus setup with long term storage capabilities"
  homepage "https://example.org/thanos"
  version "0.42.5"
  url "http://127.0.0.1:8080/brew/bottles/thanos--0.42.5.loongarch64.bottle.tar.gz"
  sha256 "196b1cfd4f362302c8cb7be0def649e6f7053dd4a998227b95b7f5ef1caa0484"

  def install
    bin.install "thanos"
  end

  test do
    system "#{bin}/thanos"
  end
end
