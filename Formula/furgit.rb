class Furgit < Formula
  desc "Low-level Git plumbing library in pure Go"
  homepage "https://example.org/furgit"
  version "0.1.184"
  url "http://127.0.0.1:8080/brew/bottles/furgit--0.1.184.loongarch64.bottle.tar.gz"
  sha256 "cb8902429d92188488c37b09d72696ffed7e7a91fd5bc194074c8a887e454d70"

  def install
    bin.install "furgit"
  end

  test do
    system "#{bin}/furgit"
  end
end
