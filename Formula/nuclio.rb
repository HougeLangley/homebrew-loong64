class Nuclio < Formula
  desc "High-Performance Serverless event and data processing platform"
  homepage "https://example.org/nuclio"
  version "1.17.11"
  url "http://127.0.0.1:8080/brew/bottles/nuclio--1.17.11.loongarch64.bottle.tar.gz"
  sha256 "22bee8e5898c8117c551a896e148c1d6d8e2056b22944caa91919393ed7728e4"

  def install
    bin.install "nuclio"
  end

  test do
    system "#{bin}/nuclio"
  end
end
