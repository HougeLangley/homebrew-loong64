class Apko < Formula
  desc "Build OCI images from APK packages directly without Dockerfile"
  homepage "https://example.org/apko"
  version "1.4.13"
  url "http://127.0.0.1:8080/brew/bottles/apko--1.4.13.loongarch64.bottle.tar.gz"
  sha256 "0a69a29d1bbdeb9452c81056f482a7e3b7ecfc7f8bcd4b39a502bdebae0013f5"

  def install
    bin.install "apko"
  end

  test do
    system "#{bin}/apko"
  end
end
