class Labctl < Formula
  desc "CLI tool for interacting with iximiuz labs and playgrounds"
  homepage "https://example.org/labctl"
  version "0.1.114"
  url "http://127.0.0.1:8080/brew/bottles/labctl--0.1.114.loongarch64.bottle.tar.gz"
  sha256 "0a06f496c59833aa566a48fb61ddd3ee69c09f35c1db1423a7d81410e6a98af6"

  def install
    bin.install "labctl"
  end

  test do
    system "#{bin}/labctl"
  end
end
