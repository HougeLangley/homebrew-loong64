class Go-termd < Formula
  desc "Package termd provides terminal markdown rendering, with code block syntax highlighting su"
  homepage "https://example.org/go-termd"
  version "0.0.1"
  url "http://127.0.0.1:8080/brew/bottles/go-termd--0.0.1.loongarch64.bottle.tar.gz"
  sha256 "22540ab72d03ef9800694d185ae9d415cc04b9f3581ebce5ad3538845e90dcce"

  def install
    bin.install "go-termd"
  end

  test do
    system "#{bin}/go-termd"
  end
end
