class Shuttle-cli < Formula
  desc "CLI for handling shared build and deploy tools between many projects"
  homepage "https://example.org/shuttle-cli"
  version "0.25.2"
  url "http://127.0.0.1:8080/brew/bottles/shuttle-cli--0.25.2.loongarch64.bottle.tar.gz"
  sha256 "4dc38afdced613d6859e4c5ffc58d63496d75f12726a8703a6d887402cd8d691"

  def install
    bin.install "shuttle-cli"
  end

  test do
    system "#{bin}/shuttle-cli"
  end
end
