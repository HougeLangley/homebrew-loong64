class Today < Formula
  desc "View your commit history across multiple directories, ideal for daily standup."
  homepage "https://example.org/today"
  version "0.1.3"
  url "http://127.0.0.1:8080/brew/bottles/today--0.1.3.loongarch64.bottle.tar.gz"
  sha256 "92b36493cc7f4aad572494a7baca9c7ea121e7de9b341556079d96e892f4ab7a"

  def install
    bin.install "today"
  end

  test do
    system "#{bin}/today"
  end
end
