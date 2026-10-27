class Lego < Formula
  desc "Let's Encrypt/ACME client and library written in Go"
  homepage "https://example.org/lego"
  version "5.5.2"
  url "http://127.0.0.1:8080/brew/bottles/lego--5.5.2.loongarch64.bottle.tar.gz"
  sha256 "5f74c3239cefd5fc5ea0472d809b61551788b22241f81edf5c35f26dd883bdfe"

  def install
    bin.install "lego"
  end

  test do
    system "#{bin}/lego"
  end
end
