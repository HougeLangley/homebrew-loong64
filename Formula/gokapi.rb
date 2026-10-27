class Gokapi < Formula
  desc "Lightweight selfhosted Firefox Send alternative without public upload. AWS S3 supported."
  homepage "https://example.org/gokapi"
  version "2.2.4"
  url "http://127.0.0.1:8080/brew/bottles/gokapi--2.2.4.loongarch64.bottle.tar.gz"
  sha256 "4b1a49ea208635a9c76e9b1ffbd9fb820d07242bc1f54915198f8512dd8f4eb3"

  def install
    bin.install "gokapi"
  end

  test do
    system "#{bin}/gokapi"
  end
end
