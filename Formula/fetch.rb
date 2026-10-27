class Fetch < Formula
  desc "Download files, folders, and release assets from a specific git commit, branch, or tag of "
  homepage "https://example.org/fetch"
  version "0.4.8"
  url "http://127.0.0.1:8080/brew/bottles/fetch--0.4.8.loongarch64.bottle.tar.gz"
  sha256 "6bab27b14d99ce5316d9421c12e95a600cf92d499cfba80fe71b9a5f7965f762"

  def install
    bin.install "fetch"
  end

  test do
    system "#{bin}/fetch"
  end
end
