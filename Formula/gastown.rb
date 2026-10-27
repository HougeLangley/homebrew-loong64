class Gastown < Formula
  desc "Multi-agent workspace manager"
  homepage "https://example.org/gastown"
  version "1.2.1"
  url "http://127.0.0.1:8080/brew/bottles/gastown--1.2.1.loongarch64.bottle.tar.gz"
  sha256 "b72bd12b160053c8101ebfceb5245322af3684dc2525264585499780436513f9"

  def install
    bin.install "gastown"
  end

  test do
    system "#{bin}/gastown"
  end
end
