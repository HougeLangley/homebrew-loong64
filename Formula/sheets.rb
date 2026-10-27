class Sheets < Formula
  desc "Terminal based spreadsheet tool"
  homepage "https://example.org/sheets"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/sheets--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "6b787bc489eb3148f8590644b932d269c4590361e8443bc186b2972c03d95003"

  def install
    bin.install "sheets"
  end

  test do
    system "#{bin}/sheets"
  end
end
