class Jsonnet-bundler < Formula
  desc "Package manager for Jsonnet"
  homepage "https://example.org/jsonnet-bundler"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/jsonnet-bundler--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "7fcf98dbbdf5e8797d6324557a58697eb366f3237fc68a83c8dd74458d45c017"

  def install
    bin.install "jsonnet-bundler"
  end

  test do
    system "#{bin}/jsonnet-bundler"
  end
end
