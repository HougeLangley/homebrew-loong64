class Orla < Formula
  desc "An open-source high performance execution engine for agentic workflows"
  homepage "https://example.org/orla"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/orla--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "0a053b1dbf855a7191f74b6afe74f178a7ef504df5832d902d3787d01146602a"

  def install
    bin.install "orla"
  end

  test do
    system "#{bin}/orla"
  end
end
