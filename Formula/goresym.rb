class Goresym < Formula
  desc "Go symbol recovery tool"
  homepage "https://example.org/goresym"
  version "3.4.1"
  url "http://127.0.0.1:8080/brew/bottles/goresym--3.4.1.loongarch64.bottle.tar.gz"
  sha256 "88c0b2fc7d6938a29938340e8e8ae4897f082bc76932d792965088554d02cbf5"

  def install
    bin.install "goresym"
  end

  test do
    system "#{bin}/goresym"
  end
end
