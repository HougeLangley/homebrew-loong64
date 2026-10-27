class Gitbatch < Formula
  desc "manage your git repositories in one place"
  homepage "https://example.org/gitbatch"
  version "0.6.1"
  url "http://127.0.0.1:8080/brew/bottles/gitbatch--0.6.1.loongarch64.bottle.tar.gz"
  sha256 "ff1f0a8502bf5358249dadb150b961f98c2bfc5f8987db41264ba5571a7b4c30"

  def install
    bin.install "gitbatch"
  end

  test do
    system "#{bin}/gitbatch"
  end
end
