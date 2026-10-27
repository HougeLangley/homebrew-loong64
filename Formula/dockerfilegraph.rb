class Dockerfilegraph < Formula
  desc "Visualize your multi-stage Dockerfiles"
  homepage "https://example.org/dockerfilegraph"
  version "0.21.0"
  url "http://127.0.0.1:8080/brew/bottles/dockerfilegraph--0.21.0.loongarch64.bottle.tar.gz"
  sha256 "fcb811edab779af506f1f46a03371052d7df2aaaadd037fde8452d218e44b025"

  def install
    bin.install "dockerfilegraph"
  end

  test do
    system "#{bin}/dockerfilegraph"
  end
end
