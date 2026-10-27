class Benchi < Formula
  desc "Benchmarking tool for data pipelines"
  homepage "https://example.org/benchi"
  version "0.4.1"
  url "http://127.0.0.1:8080/brew/bottles/benchi--0.4.1.loongarch64.bottle.tar.gz"
  sha256 "5a3300135356f12064c6169dd164e59d15a1405c6371cc2a1440a841d66ce253"

  def install
    bin.install "benchi"
  end

  test do
    system "#{bin}/benchi"
  end
end
