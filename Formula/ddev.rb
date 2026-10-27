class Ddev < Formula
  desc "Docker-based local PHP+Node.js web development environments"
  homepage "https://example.org/ddev"
  version "1.25.5"
  url "http://127.0.0.1:8080/brew/bottles/ddev--1.25.5.loongarch64.bottle.tar.gz"
  sha256 "1678e0bc1dede639e71fcd689b3af231acf21c9f7954ccde88ec7b14fb9f06ac"

  def install
    bin.install "ddev"
  end

  test do
    system "#{bin}/ddev"
  end
end
