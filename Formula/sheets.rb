class Sheets < Formula
  desc "Terminal based spreadsheet tool"
  homepage "https://example.org/sheets"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/sheets--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "6145e618bad4367663df7fa9a1213c093354cdca5f0cc2c1c898f3413faa43fe"

  def install
    bin.install "sheets"
  end

  test do
    system "#{bin}/sheets"
  end
end
