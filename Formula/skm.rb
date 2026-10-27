class Skm < Formula
  desc "Simple and powerful SSH keys manager"
  homepage "https://example.org/skm"
  version "0.9.3"
  url "http://127.0.0.1:8080/brew/bottles/skm--0.9.3.loongarch64.bottle.tar.gz"
  sha256 "e0e913a3684b1f28a3aa34aa4fe5fde299024813159b8e8a1883ce6ec1b190da"

  def install
    bin.install "skm"
  end

  test do
    system "#{bin}/skm"
  end
end
