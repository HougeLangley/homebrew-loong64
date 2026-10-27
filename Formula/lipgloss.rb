class Lipgloss < Formula
  desc "Style definitions for nice terminal layouts 👄"
  homepage "https://example.org/lipgloss"
  version "2.0.6"
  url "http://127.0.0.1:8080/brew/bottles/lipgloss--2.0.6.loongarch64.bottle.tar.gz"
  sha256 "2d977c9e218c5562c24b1b21c9bde538dbbe91e3139fd4749b972bc68fd402ac"

  def install
    bin.install "lipgloss"
  end

  test do
    system "#{bin}/lipgloss"
  end
end
