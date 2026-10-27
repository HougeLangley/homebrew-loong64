class Jq-lsp < Formula
  desc "Jq language server"
  homepage "https://example.org/jq-lsp"
  version "0.1.19"
  url "http://127.0.0.1:8080/brew/bottles/jq-lsp--0.1.19.loongarch64.bottle.tar.gz"
  sha256 "b7b4451b8de7fb99a918b0682db6750241e494313e9a608c8091b840bd48cb31"

  def install
    bin.install "jq-lsp"
  end

  test do
    system "#{bin}/jq-lsp"
  end
end
