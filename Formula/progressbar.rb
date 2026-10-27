class Progressbar < Formula
  desc "A really basic thread-safe progress bar for Golang applications"
  homepage "https://example.org/progressbar"
  version "3.19.1"
  url "http://127.0.0.1:8080/brew/bottles/progressbar--3.19.1.loongarch64.bottle.tar.gz"
  sha256 "f9d88b1eda6d12456c2c776c1ff3301d9b1d8e37ec462e82c47b2665dee21bc2"

  def install
    bin.install "progressbar"
  end

  test do
    system "#{bin}/progressbar"
  end
end
