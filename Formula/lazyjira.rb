class Lazyjira < Formula
  desc "Lazygit but for Jira"
  homepage "https://example.org/lazyjira"
  version "2.19.2"
  url "http://127.0.0.1:8080/brew/bottles/lazyjira--2.19.2.loongarch64.bottle.tar.gz"
  sha256 "112f6a5f3d269759c066aa86353c110288dc620608cdac9ed9cd80a8a18cefc4"

  def install
    bin.install "lazyjira"
  end

  test do
    system "#{bin}/lazyjira"
  end
end
