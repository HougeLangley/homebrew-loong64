class Fil < Formula
  desc ":yum: Unix file command written in Go"
  homepage "https://example.org/fil"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/fil--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "24e62fd4f6112d82bb2e87e43f35a7e7612f358c243e30b72d29de06a35392e2"

  def install
    bin.install "fil"
  end

  test do
    system "#{bin}/fil"
  end
end
