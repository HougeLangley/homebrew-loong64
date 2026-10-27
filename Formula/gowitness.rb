class Gowitness < Formula
  desc "🔍 gowitness - a golang, web screenshot utility using Chrome Headless"
  homepage "https://example.org/gowitness"
  version "3.2.2"
  url "http://127.0.0.1:8080/brew/bottles/gowitness--3.2.2.loongarch64.bottle.tar.gz"
  sha256 "cb3425e815c36493bec5b548de106e940a7047b70fbae160ac90d790b385d048"

  def install
    bin.install "gowitness"
  end

  test do
    system "#{bin}/gowitness"
  end
end
