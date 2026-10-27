class Gotty < Formula
  desc "Share your terminal as a web application"
  homepage "https://example.org/gotty"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/gotty--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "70928a3cc6426a9ba1fd76cb80ae9062dbbc0f53ccecb0a7a7dfce2bdce0f7d4"

  def install
    bin.install "gotty"
  end

  test do
    system "#{bin}/gotty"
  end
end
