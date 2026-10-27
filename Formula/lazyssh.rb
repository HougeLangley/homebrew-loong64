class Lazyssh < Formula
  desc "A terminal-based SSH manager inspired by lazydocker and k9s - Written in go"
  homepage "https://example.org/lazyssh"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/lazyssh--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "be61f72957bd6544986ef3ad846478acbceb96d83d694988d0698a90b721259f"

  def install
    bin.install "lazyssh"
  end

  test do
    system "#{bin}/lazyssh"
  end
end
