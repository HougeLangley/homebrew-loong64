class Jj < Formula
  desc "Git-compatible VCS"
  homepage "https://example.org/jj"
  version "0.46.0"
  url "http://127.0.0.1:8080/brew/bottles/jj--0.46.0.loongarch64.bottle.tar.gz"
  sha256 "6bc17d471221060a70555fac701d764c29f7fd6aab24c9f085492c035196f82a"

  def install
    bin.install "jj"
  end

  test do
    system "#{bin}/jj"
  end
end
