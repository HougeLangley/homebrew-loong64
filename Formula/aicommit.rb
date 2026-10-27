class Aicommit < Formula
  desc "become the world's laziest committer"
  homepage "https://example.org/aicommit"
  version "0.6.5"
  url "http://127.0.0.1:8080/brew/bottles/aicommit--0.6.5.loongarch64.bottle.tar.gz"
  sha256 "ecda7b5580dbe4dcfcfb4daa5df056f6ce3887f9f05ac70201a28add93bfaf21"

  def install
    bin.install "aicommit"
  end

  test do
    system "#{bin}/aicommit"
  end
end
