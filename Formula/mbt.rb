class Mbt < Formula
  desc "The most flexible build tool for monorepo"
  homepage "https://example.org/mbt"
  version "0.24"
  url "http://127.0.0.1:8080/brew/bottles/mbt--0.24.loongarch64.bottle.tar.gz"
  sha256 "f611fb54f3f8f038904d302438594d4a9a06ea9a04848c11cd811868053ce1d4"

  def install
    bin.install "mbt"
  end

  test do
    system "#{bin}/mbt"
  end
end
