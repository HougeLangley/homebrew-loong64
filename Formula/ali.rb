class Ali < Formula
  desc "Generate HTTP load and plot the results in real-time"
  homepage "https://example.org/ali"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/ali--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "56f11085fd175ba7fa1936d2b8192faee713745db290a0c9c824a274ede32ed5"

  def install
    bin.install "ali"
  end

  test do
    system "#{bin}/ali"
  end
end
