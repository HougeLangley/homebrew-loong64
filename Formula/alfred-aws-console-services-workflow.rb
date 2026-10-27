class Alfred-aws-console-services-workflow < Formula
  desc "A powerful workflow for quickly opening up AWS Console Services in your browser or searchi"
  homepage "https://example.org/alfred-aws-console-services-workflow"
  version "6.2.0"
  url "http://127.0.0.1:8080/brew/bottles/alfred-aws-console-services-workflow--6.2.0.loongarch64.bottle.tar.gz"
  sha256 "3bfc1d4ca9b245ed655c980852bdf0dc78023386af6e00f7af86e0a4d3066105"

  def install
    bin.install "alfred-aws-console-services-workflow"
  end

  test do
    system "#{bin}/alfred-aws-console-services-workflow"
  end
end
