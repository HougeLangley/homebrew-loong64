class Savvy-cli < Formula
  desc "Automatically capture and surface your team's tribal knowledge"
  homepage "https://example.org/savvy-cli"
  version "0.23.0"
  url "http://127.0.0.1:8080/brew/bottles/savvy-cli--0.23.0.loongarch64.bottle.tar.gz"
  sha256 "5a48fa31fc58517c4bb5fa2778e45d463b85d9d859fc6b0b3ce3679b2237b239"

  def install
    bin.install "savvy-cli"
  end

  test do
    system "#{bin}/savvy-cli"
  end
end
