class Copa < Formula
  desc "Tool to directly patch container images given the vulnerability scanning results"
  homepage "https://example.org/copa"
  version "0.15.0"
  url "http://127.0.0.1:8080/brew/bottles/copa--0.15.0.loongarch64.bottle.tar.gz"
  sha256 "94d70b6d45078c1d00f64680b23f6b0b5c1c0b1d766a3e8a512d9ac454e7a3fb"

  def install
    bin.install "copa"
  end

  test do
    system "#{bin}/copa"
  end
end
