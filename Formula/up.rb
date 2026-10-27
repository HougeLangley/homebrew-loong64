class Up < Formula
  desc "Deploy infinitely scalable serverless apps, apis, and sites in seconds to AWS."
  homepage "https://example.org/up"
  version "1.7.1"
  url "http://127.0.0.1:8080/brew/bottles/up--1.7.1.loongarch64.bottle.tar.gz"
  sha256 "7ecddd0420a1c7585f9b9f7194866786275c7681652833d2c75e29520b596b95"

  def install
    bin.install "up"
  end

  test do
    system "#{bin}/up"
  end
end
