class Consul < Formula
  desc "Consul is a distributed, highly available, and data center aware solution to connect and c"
  homepage "https://example.org/consul"
  version "2.1.0"
  url "http://127.0.0.1:8080/brew/bottles/consul--2.1.0.loongarch64.bottle.tar.gz"
  sha256 "1ef29250aa4ee014ab5e2ad2b40eb2ca8211aeaae1e2cdb08048f64620f30bbc"

  def install
    bin.install "consul"
  end

  test do
    system "#{bin}/consul"
  end
end
