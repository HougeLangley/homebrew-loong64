class Croc < Formula
  desc "Securely send things from one computer to another"
  homepage "https://example.org/croc"
  version "11.5.5"
  url "http://127.0.0.1:8080/brew/bottles/croc--11.5.5.loongarch64.bottle.tar.gz"
  sha256 "337b73f4a8f2aa7490646944c15db5c49c8320e0693c8e384d47352f1e3b49d8"

  def install
    bin.install "croc"
  end

  test do
    system "#{bin}/croc"
  end
end
