class Ghz < Formula
  desc "Simple gRPC benchmarking and load testing tool"
  homepage "https://example.org/ghz"
  version "0.121.0"
  url "http://127.0.0.1:8080/brew/bottles/ghz--0.121.0.loongarch64.bottle.tar.gz"
  sha256 "318735b50003a1703e4b40184fad77c88500e641166fe83ef7d567da4deeffe6"

  def install
    bin.install "ghz"
  end

  test do
    system "#{bin}/ghz"
  end
end
