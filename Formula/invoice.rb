class Invoice < Formula
  desc "Command-line invoice generator"
  homepage "https://example.org/invoice"
  version "0.1.0"
  url "http://127.0.0.1:8080/brew/bottles/invoice--0.1.0.loongarch64.bottle.tar.gz"
  sha256 "2a10fe99a41cd356292903441e4ace7a79da53ae1504c0d2e79b320c92484a7c"

  def install
    bin.install "invoice"
  end

  test do
    system "#{bin}/invoice"
  end
end
