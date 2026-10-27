class Go-containerregistry < Formula
  desc "Go library and CLIs for working with container registries"
  homepage "https://example.org/go-containerregistry"
  version "0.22.1"
  url "http://127.0.0.1:8080/brew/bottles/go-containerregistry--0.22.1.loongarch64.bottle.tar.gz"
  sha256 "187f1ee090913da561b627140c3864d81cd5b363ff82e9d441cb1ee019c47b58"

  def install
    bin.install "go-containerregistry"
  end

  test do
    system "#{bin}/go-containerregistry"
  end
end
