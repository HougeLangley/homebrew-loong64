class Aws-es-proxy < Formula
  desc "Small proxy between HTTP client and AWS Elasticsearch"
  homepage "https://example.org/aws-es-proxy"
  version "1.5"
  url "http://127.0.0.1:8080/brew/bottles/aws-es-proxy--1.5.loongarch64.bottle.tar.gz"
  sha256 "a5837160d02fc172e7ee6f1957f01a62a4633255fa5d41bacec2c48f7fbf77dc"

  def install
    bin.install "aws-es-proxy"
  end

  test do
    system "#{bin}/aws-es-proxy"
  end
end
