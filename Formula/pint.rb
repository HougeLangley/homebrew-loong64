class Pint < Formula
  desc "Prometheus rule linter/validator"
  homepage "https://example.org/pint"
  version "0.89.4"
  url "http://127.0.0.1:8080/brew/bottles/pint--0.89.4.loongarch64.bottle.tar.gz"
  sha256 "26f1ed0b03394c9ed35f422acb03c8ad51c69faec64ef293f29bc37cd4bf8d36"

  def install
    bin.install "pint"
  end

  test do
    system "#{bin}/pint"
  end
end
