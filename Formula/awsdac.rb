class Awsdac < Formula
  desc "CLI tool for drawing AWS architecture"
  homepage "https://example.org/awsdac"
  version "0.24"
  url "http://127.0.0.1:8080/brew/bottles/awsdac--0.24.loongarch64.bottle.tar.gz"
  sha256 "bdaab57ad32ffd80f830c34654c07cd1aadc932b42863be3db55af8eca75ec89"

  def install
    bin.install "awsdac"
  end

  test do
    system "#{bin}/awsdac"
  end
end
