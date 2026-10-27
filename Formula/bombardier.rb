class Bombardier < Formula
  desc "Fast cross-platform HTTP benchmarking tool written in Go"
  homepage "https://example.org/bombardier"
  version "2.0.2"
  url "http://127.0.0.1:8080/brew/bottles/bombardier--2.0.2.loongarch64.bottle.tar.gz"
  sha256 "0060604d4c21c502c00efe831d93baacc907ace6a0ffc63eeb88a57705a4a5e5"

  def install
    bin.install "bombardier"
  end

  test do
    system "#{bin}/bombardier"
  end
end
