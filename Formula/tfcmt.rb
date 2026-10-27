class Tfcmt < Formula
  desc "Notify the execution result of terraform command"
  homepage "https://example.org/tfcmt"
  version "4.14.20"
  url "http://127.0.0.1:8080/brew/bottles/tfcmt--4.14.20.loongarch64.bottle.tar.gz"
  sha256 "1800356ee881f8a89ce115efb450a6c713a1338c4ee9d9e3ba490aaca75aabbe"

  def install
    bin.install "tfcmt"
  end

  test do
    system "#{bin}/tfcmt"
  end
end
