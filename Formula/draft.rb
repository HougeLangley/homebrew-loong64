class Draft < Formula
  desc "Day 0 tool for getting your app on Kubernetes fast"
  homepage "https://example.org/draft"
  version "0.17.17"
  url "http://127.0.0.1:8080/brew/bottles/draft--0.17.17.loongarch64.bottle.tar.gz"
  sha256 "1cd1d6c1a33afd59a74cb0cf836330d1d90fdfc9e007179c57cb903243ed850f"

  def install
    bin.install "draft"
  end

  test do
    system "#{bin}/draft"
  end
end
