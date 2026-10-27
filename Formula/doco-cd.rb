class Doco-cd < Formula
  desc "Docker Compose Continuous Deployment"
  homepage "https://example.org/doco-cd"
  version "0.130.0"
  url "http://127.0.0.1:8080/brew/bottles/doco-cd--0.130.0.loongarch64.bottle.tar.gz"
  sha256 "23b14ebb34cca34e32c218a6f33ce48e9d883b2bae7f0a4e99dd07429c005aba"

  def install
    bin.install "doco-cd"
  end

  test do
    system "#{bin}/doco-cd"
  end
end
