class Soar < Formula
  desc "SQL Optimizer And Rewriter"
  homepage "https://example.org/soar"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/soar--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "edef73b6f75f6a773919048e9ab6869623d85c7568a009b1c08bf1ec43b530e3"

  def install
    bin.install "soar"
  end

  test do
    system "#{bin}/soar"
  end
end
