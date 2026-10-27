class Stormy < Formula
  desc "Minimal, customizable and neofetch-like weather CLI based on rainy"
  homepage "https://example.org/stormy"
  version "0.3.3"
  url "http://127.0.0.1:8080/brew/bottles/stormy--0.3.3.loongarch64.bottle.tar.gz"
  sha256 "bd5f9f63193c7c9a7c844f7297b236aaef0170e2604799d61ccb133895ad9412"

  def install
    bin.install "stormy"
  end

  test do
    system "#{bin}/stormy"
  end
end
