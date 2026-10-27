class Api-testing < Formula
  desc "Open source API testing tool. 开源接口调试、测试工具。Mock Server"
  homepage "https://example.org/api-testing"
  version "0.0.21"
  url "http://127.0.0.1:8080/brew/bottles/api-testing--0.0.21.loongarch64.bottle.tar.gz"
  sha256 "3288c0e257d5a01ed130580f0aff524bd40476ee92faa6667eb220acd31c74f9"

  def install
    bin.install "api-testing"
  end

  test do
    system "#{bin}/api-testing"
  end
end
