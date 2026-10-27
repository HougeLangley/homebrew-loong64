class Goreman < Formula
  desc "foreman clone written in go language"
  homepage "https://example.org/goreman"
  version "0.3.19"
  url "http://127.0.0.1:8080/brew/bottles/goreman--0.3.19.loongarch64.bottle.tar.gz"
  sha256 "b12539b5d87e504438a91b19473cc4baa226e6dab4a07e448291f5421f44b7f9"

  def install
    bin.install "goreman"
  end

  test do
    system "#{bin}/goreman"
  end
end
