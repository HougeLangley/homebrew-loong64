class Git-hooks-go < Formula
  desc "Git hooks manager"
  homepage "https://example.org/git-hooks-go"
  version "1.3.1"
  url "http://127.0.0.1:8080/brew/bottles/git-hooks-go--1.3.1.loongarch64.bottle.tar.gz"
  sha256 "994b6848ddc2abb90db55f2318e35d1190d6682b942d3c4a9efd5bfe4dff19f4"

  def install
    bin.install "git-hooks-go"
  end

  test do
    system "#{bin}/git-hooks-go"
  end
end
