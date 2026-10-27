class Api-linter < Formula
  desc "Linter for APIs defined in protocol buffers"
  homepage "https://example.org/api-linter"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/api-linter--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "70d53d9827141d86910c5d85a5000c70a74e62c3a383dec464c707cad74cf093"

  def install
    bin.install "api-linter"
  end

  test do
    system "#{bin}/api-linter"
  end
end
