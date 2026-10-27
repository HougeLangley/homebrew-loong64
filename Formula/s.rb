class S < Formula
  desc "Open a web search in your terminal."
  homepage "https://example.org/s"
  version "0.8.1"
  url "http://127.0.0.1:8080/brew/bottles/s--0.8.1.loongarch64.bottle.tar.gz"
  sha256 "47b1b651845bdca6ec894a64c93c154add0b3f51c44c78cbf57e8556c147e27b"

  def install
    bin.install "s"
  end

  test do
    system "#{bin}/s"
  end
end
