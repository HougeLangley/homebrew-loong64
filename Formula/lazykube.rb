class Lazykube < Formula
  desc "⎈ The lazier way to manage kubernetes."
  homepage "https://example.org/lazykube"
  version "0.10.3"
  url "http://127.0.0.1:8080/brew/bottles/lazykube--0.10.3.loongarch64.bottle.tar.gz"
  sha256 "4a820bbdf8634b0bf26f2990ccbae12fc6d89f79304fbe69d113092e81f9e266"

  def install
    bin.install "lazykube"
  end

  test do
    system "#{bin}/lazykube"
  end
end
