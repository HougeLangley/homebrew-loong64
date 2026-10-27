class Devspace < Formula
  desc "DevSpace - The Fastest Developer Tool for Kubernetes ⚡ Automate your deployment workflow w"
  homepage "https://example.org/devspace"
  version "6.3.21"
  url "http://127.0.0.1:8080/brew/bottles/devspace--6.3.21.loongarch64.bottle.tar.gz"
  sha256 "87c289ebcb2ec0b5314251e2243783cbbcac3be831d88705bd14b2eb70ac73cf"

  def install
    bin.install "devspace"
  end

  test do
    system "#{bin}/devspace"
  end
end
