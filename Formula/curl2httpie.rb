class Curl2httpie < Formula
  desc "covert command arguments between cURL and HTTPie"
  homepage "https://example.org/curl2httpie"
  version "1.9"
  url "http://127.0.0.1:8080/brew/bottles/curl2httpie--1.9.loongarch64.bottle.tar.gz"
  sha256 "022cf845c97433314bb8c6e978103495e12b865a0f2a51b9e92f29c98ac445dc"

  def install
    bin.install "curl2httpie"
  end

  test do
    system "#{bin}/curl2httpie"
  end
end
