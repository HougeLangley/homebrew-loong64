class Aqua < Formula
  desc "Declarative CLI Version manager written in Go. Support Lazy Install, Registry, and continu"
  homepage "https://example.org/aqua"
  version "2.65.2"
  url "http://127.0.0.1:8080/brew/bottles/aqua--2.65.2.loongarch64.bottle.tar.gz"
  sha256 "1c6b63d919c8e233e8b6e621a39e85d1d5c15172787c474e560126246dee5131"

  def install
    bin.install "aqua"
  end

  test do
    system "#{bin}/aqua"
  end
end
