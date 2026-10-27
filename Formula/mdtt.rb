class Mdtt < Formula
  desc "🗓️ Markdown Table Editor TUI"
  homepage "https://example.org/mdtt"
  version "0.3.1"
  url "http://127.0.0.1:8080/brew/bottles/mdtt--0.3.1.loongarch64.bottle.tar.gz"
  sha256 "a55f171ec1fa5f6cccb01e609dd204d551c0b7e0fcf271c385f4c619eab4c7d5"

  def install
    bin.install "mdtt"
  end

  test do
    system "#{bin}/mdtt"
  end
end
