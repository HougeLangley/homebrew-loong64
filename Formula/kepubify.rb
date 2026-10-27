class Kepubify < Formula
  desc "Convert ebooks from epub to kepub"
  homepage "https://example.org/kepubify"
  version "4.0.4"
  url "http://127.0.0.1:8080/brew/bottles/kepubify--4.0.4.loongarch64.bottle.tar.gz"
  sha256 "8114feaf86f2c4105c58f922813e78ebb9dd3b6cf6de7f91dbf3f527d6eb8e2b"

  def install
    bin.install "kepubify"
  end

  test do
    system "#{bin}/kepubify"
  end
end
