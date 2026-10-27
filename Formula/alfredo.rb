class Alfredo < Formula
  desc "Alfred for Todoist"
  homepage "https://example.org/alfredo"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/alfredo--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "d9e5ebe534d9a25378e669d9b6e610aaca405d0e362b6f53b158fea8a75eaa98"

  def install
    bin.install "alfredo"
  end

  test do
    system "#{bin}/alfredo"
  end
end
