class Atlas < Formula
  desc "Database toolkit"
  homepage "https://example.org/atlas"
  version "1.3.0"
  url "http://127.0.0.1:8080/brew/bottles/atlas--1.3.0.loongarch64.bottle.tar.gz"
  sha256 "d9761e7c67b39903719d4a3516940e975eba7cfea750ac8ae63c5d0fd2110594"

  def install
    bin.install "atlas"
  end

  test do
    system "#{bin}/atlas"
  end
end
