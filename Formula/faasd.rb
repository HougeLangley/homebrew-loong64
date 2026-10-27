class Faasd < Formula
  desc "Lightweight and portable version of OpenFaaS"
  homepage "https://example.org/faasd"
  version "0.19.7"
  url "http://127.0.0.1:8080/brew/bottles/faasd--0.19.7.loongarch64.bottle.tar.gz"
  sha256 "5fc3babaee66c155f70e81dc32964ff97affe6f0d163ccf8904c35ec0d454e65"

  def install
    bin.install "faasd"
  end

  test do
    system "#{bin}/faasd"
  end
end
