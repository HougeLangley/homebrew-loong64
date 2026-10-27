class Chroma < Formula
  desc "General purpose syntax highlighter in pure Go"
  homepage "https://example.org/chroma"
  version "3.0.0-alpha.5"
  url "http://127.0.0.1:8080/brew/bottles/chroma--3.0.0-alpha.5.loongarch64.bottle.tar.gz"
  sha256 "816d450351b7a3ec402fed2c6f191de9fbc1d3fdde851fad0042a1cdff3bf543"

  def install
    bin.install "chroma"
  end

  test do
    system "#{bin}/chroma"
  end
end
