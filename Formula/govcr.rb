class Govcr < Formula
  desc "HTTP mock for Golang: record and replay HTTP/HTTPS interactions for offline testing"
  homepage "https://example.org/govcr"
  version "17.1.0"
  url "http://127.0.0.1:8080/brew/bottles/govcr--17.1.0.loongarch64.bottle.tar.gz"
  sha256 "4f164f40df60098b8f2d237f5c046439ba8699ae0701b3bf761f5aa2da3cfea7"

  def install
    bin.install "govcr"
  end

  test do
    system "#{bin}/govcr"
  end
end
