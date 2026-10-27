class Sensu-go < Formula
  desc "Simple. Scalable. Multi-cloud monitoring."
  homepage "https://example.org/sensu-go"
  version "6.15.0"
  url "http://127.0.0.1:8080/brew/bottles/sensu-go--6.15.0.loongarch64.bottle.tar.gz"
  sha256 "e8e4c681ef9189560c63b0b106acb4228f687ed8cfdf88e0d067b5b047eadbe0"

  def install
    bin.install "sensu-go"
  end

  test do
    system "#{bin}/sensu-go"
  end
end
