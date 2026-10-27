class Go-parquet-tools < Formula
  desc "Utility to deal with Parquet data"
  homepage "https://example.org/go-parquet-tools"
  version "1.56.4"
  url "http://127.0.0.1:8080/brew/bottles/go-parquet-tools--1.56.4.loongarch64.bottle.tar.gz"
  sha256 "85ee01a651fee93f4b087274e8385e0ed0376421516158695893d5ca27fd0093"

  def install
    bin.install "go-parquet-tools"
  end

  test do
    system "#{bin}/go-parquet-tools"
  end
end
