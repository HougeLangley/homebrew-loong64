class Glider < Formula
  desc "Forward proxy with multiple protocols support"
  homepage "https://example.org/glider"
  version "0.16.4"
  url "http://127.0.0.1:8080/brew/bottles/glider--0.16.4.loongarch64.bottle.tar.gz"
  sha256 "15d97a55cec1dac21c9cbaae91b0de30895cf28de6099d17c907e536a9c105ed"

  def install
    bin.install "glider"
  end

  test do
    system "#{bin}/glider"
  end
end
