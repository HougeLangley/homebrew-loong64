class Scc < Formula
  desc "Fast code counter and complexity estimator"
  homepage "https://example.org/scc"
  version "4.1.0"
  url "http://127.0.0.1:8080/brew/bottles/scc--4.1.0.loongarch64.bottle.tar.gz"
  sha256 "d6839bf6d9d12592da9376fcbf4d902e8cbca2aff081950151845337a4730f0e"

  def install
    bin.install "scc"
  end

  test do
    system "#{bin}/scc"
  end
end
