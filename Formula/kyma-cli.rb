class Kyma-cli < Formula
  desc "Kyma command-line interface"
  homepage "https://example.org/kyma-cli"
  version "3.5.0"
  url "http://127.0.0.1:8080/brew/bottles/kyma-cli--3.5.0.loongarch64.bottle.tar.gz"
  sha256 "849233a3627e03bcecfdb639b86603cd477d6f34622c43222691f494c9ad7ba3"

  def install
    bin.install "kyma-cli"
  end

  test do
    system "#{bin}/kyma-cli"
  end
end
