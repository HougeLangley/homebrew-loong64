class Go-tea < Formula
  desc "Tea provides an Elm inspired functional framework for interactive command-line programs."
  homepage "https://example.org/go-tea"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/go-tea--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "557b0cf394cf786969794b74d821b88d795417807db993ba244c0e1cf2ab8399"

  def install
    bin.install "go-tea"
  end

  test do
    system "#{bin}/go-tea"
  end
end
