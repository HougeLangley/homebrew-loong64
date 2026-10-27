class Kserve < Formula
  desc "Standardized Distributed Generative and Predictive AI Inference Platform for Scalable, Mul"
  homepage "https://example.org/kserve"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/kserve--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "4564bcb166a84d2643a4c16d48944fa72779abb1de32f35739baf5c30f17af82"

  def install
    bin.install "kserve"
  end

  test do
    system "#{bin}/kserve"
  end
end
