class Ripgrep-all < Formula
  desc "Search inside pdfs and archives"
  homepage "https://example.org/ripgrep-all"
  version "0.10.10"
  url "http://127.0.0.1:8080/brew/bottles/ripgrep-all--0.10.10.loongarch64.bottle.tar.gz"
  sha256 "65f52009830ed4a120db579f19b6b3b96e8549c59427a1cdc191db34ec15366f"

  def install
    bin.install "ripgrep-all"
  end

  test do
    system "#{bin}/ripgrep-all"
  end
end
