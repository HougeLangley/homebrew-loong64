class K0sctl < Formula
  desc "Bootstrapping and management tool for k0s clusters"
  homepage "https://example.org/k0sctl"
  version "0.33.1"
  url "http://127.0.0.1:8080/brew/bottles/k0sctl--0.33.1.loongarch64.bottle.tar.gz"
  sha256 "8b2f23f1a4aa985e6a1a7b455854031019a3354f48ffed42f1bcdf26da55337d"

  def install
    bin.install "k0sctl"
  end

  test do
    system "#{bin}/k0sctl"
  end
end
