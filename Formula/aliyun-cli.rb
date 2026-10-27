class Aliyun-cli < Formula
  desc "Universal Command-Line Interface for Alibaba Cloud"
  homepage "https://example.org/aliyun-cli"
  version "3.5.2"
  url "http://127.0.0.1:8080/brew/bottles/aliyun-cli--3.5.2.loongarch64.bottle.tar.gz"
  sha256 "e2a970a420401262b834132bafd2a92093635a22ba80b8035b8f948b1c815194"

  def install
    bin.install "aliyun-cli"
  end

  test do
    system "#{bin}/aliyun-cli"
  end
end
