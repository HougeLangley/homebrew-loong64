class Jsonfmt < Formula
  desc "Like gofmt, but for JSON files"
  homepage "https://example.org/jsonfmt"
  version "0.5.2"
  url "http://127.0.0.1:8080/brew/bottles/jsonfmt--0.5.2.loongarch64.bottle.tar.gz"
  sha256 "3774a38b80668bb92ff9f714d6bfe6fd47403913e7a4ee24e5d91cde9c691256"

  def install
    bin.install "jsonfmt"
  end

  test do
    system "#{bin}/jsonfmt"
  end
end
