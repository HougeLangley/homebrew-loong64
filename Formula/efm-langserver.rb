class Efm-langserver < Formula
  desc "General purpose Language Server"
  homepage "https://example.org/efm-langserver"
  version "0.0.57"
  url "http://127.0.0.1:8080/brew/bottles/efm-langserver--0.0.57.loongarch64.bottle.tar.gz"
  sha256 "ebddae084be002d8521b38b1168c4ab4a6d38e03585cf5b38bb3453fe7692ef3"

  def install
    bin.install "efm-langserver"
  end

  test do
    system "#{bin}/efm-langserver"
  end
end
