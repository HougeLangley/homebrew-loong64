class Harbor-cli < Formula
  desc "CLI for Harbor container registry"
  homepage "https://example.org/harbor-cli"
  version "0.0.27"
  url "http://127.0.0.1:8080/brew/bottles/harbor-cli--0.0.27.loongarch64.bottle.tar.gz"
  sha256 "48a080a8af40fc8f8e7ba94473f6c4c345441e1a7e249a8a797e6ecd7aa93793"

  def install
    bin.install "harbor-cli"
  end

  test do
    system "#{bin}/harbor-cli"
  end
end
