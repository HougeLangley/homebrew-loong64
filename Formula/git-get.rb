class Git-get < Formula
  desc "A better way to clone, organize and manage multiple git repositories"
  homepage "https://example.org/git-get"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/git-get--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "5182834d00f88d7b961e5eccacf2805b76bf9029bbc4f1568a5533e980f21886"

  def install
    bin.install "git-get"
  end

  test do
    system "#{bin}/git-get"
  end
end
