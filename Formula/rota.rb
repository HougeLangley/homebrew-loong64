class Rota < Formula
  desc "A high-performance proxy rotation engine with automated IP management and real-time health"
  homepage "https://example.org/rota"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/rota--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "657372d087f5c5322396f3e99b6121dbc5253c35e92b69a3ba3cac1565025c2a"

  def install
    bin.install "rota"
  end

  test do
    system "#{bin}/rota"
  end
end
