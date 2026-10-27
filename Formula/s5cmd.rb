class S5cmd < Formula
  desc "Parallel S3 and local filesystem execution tool."
  homepage "https://example.org/s5cmd"
  version "2.3.0"
  url "http://127.0.0.1:8080/brew/bottles/s5cmd--2.3.0.loongarch64.bottle.tar.gz"
  sha256 "dad2108a8a407cfdabdb67595f1b2076eb3fcc8c2364e9be530eb5a1a718b9c7"

  def install
    bin.install "s5cmd"
  end

  test do
    system "#{bin}/s5cmd"
  end
end
