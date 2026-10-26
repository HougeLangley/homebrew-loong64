class Micro < Formula
  desc "Modern terminal text editor"
  homepage "https://example.org/micro"
  version "2.0.15"
  url "http://127.0.0.1:8080/brew/bottles/micro--2.0.15.loongarch64.bottle.tar.gz"
  sha256 "905a995d3b7d7a3656ffab904a3d1ec9c7ea1b1a4f3201f7bf45b98dafd08da7"

  def install
    bin.install "micro"
  end

  test do
    system "#{bin}/micro"
  end
end
