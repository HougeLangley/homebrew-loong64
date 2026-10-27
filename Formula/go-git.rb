class Go-git < Formula
  desc "A highly extensible Git implementation in pure Go."
  homepage "https://example.org/go-git"
  version "5.19.3"
  url "http://127.0.0.1:8080/brew/bottles/go-git--5.19.3.loongarch64.bottle.tar.gz"
  sha256 "2d8581b6fe8850f0a1e137e559f87cfd58b86d3b7ec93942afd8bca046fbd6e6"

  def install
    bin.install "go-git"
  end

  test do
    system "#{bin}/go-git"
  end
end
