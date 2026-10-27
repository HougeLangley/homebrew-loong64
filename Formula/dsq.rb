class Dsq < Formula
  desc "Commandline tool for running SQL queries against JSON, CSV, Excel, Parquet, and more."
  homepage "https://example.org/dsq"
  version "0.23.0"
  url "http://127.0.0.1:8080/brew/bottles/dsq--0.23.0.loongarch64.bottle.tar.gz"
  sha256 "0fb1283fe585ebf479a20e6f7543da145191e51c4f8efa969fa60adda815d484"

  def install
    bin.install "dsq"
  end

  test do
    system "#{bin}/dsq"
  end
end
