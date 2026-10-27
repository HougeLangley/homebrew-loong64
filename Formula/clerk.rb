class Clerk < Formula
  desc "Auto-summarize Claude Code sessions as local markdown —  session summaries, keyword index,"
  homepage "https://example.org/clerk"
  version "5.2.0"
  url "http://127.0.0.1:8080/brew/bottles/clerk--5.2.0.loongarch64.bottle.tar.gz"
  sha256 "d17ff320f32e92fefe61de0b3080d496497e069d4bd737a5776bebf76453f860"

  def install
    bin.install "clerk"
  end

  test do
    system "#{bin}/clerk"
  end
end
