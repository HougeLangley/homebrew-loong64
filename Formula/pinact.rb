class Pinact < Formula
  desc "pinact is a CLI to edit GitHub Workflow and Composite action files and pin versions of Act"
  homepage "https://example.org/pinact"
  version "5.0.2"
  url "http://127.0.0.1:8080/brew/bottles/pinact--5.0.2.loongarch64.bottle.tar.gz"
  sha256 "d01107afc4b93caadcf624b9e83ce9d4418760296741dfa6354e30ede8a38781"

  def install
    bin.install "pinact"
  end

  test do
    system "#{bin}/pinact"
  end
end
