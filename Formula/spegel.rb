class Spegel < Formula
  desc "Stateless cluster local OCI registry mirror."
  homepage "https://example.org/spegel"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/spegel--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "b5c9dc5ad296f44852a9d8b8964dd036b7d9b0025fd56348530436f5214e7b03"

  def install
    bin.install "spegel"
  end

  test do
    system "#{bin}/spegel"
  end
end
