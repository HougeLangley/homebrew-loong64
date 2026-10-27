class Vi-sql < Formula
  desc "Terminal UI for SQL databases"
  homepage "https://example.org/vi-sql"
  version "0.6.0"
  url "http://127.0.0.1:8080/brew/bottles/vi-sql--0.6.0.loongarch64.bottle.tar.gz"
  sha256 "9fbf2ff07b13aa460e475eab74e6c87becd220b395506030f3ce7c1af362ad17"

  def install
    bin.install "vi-sql"
  end

  test do
    system "#{bin}/vi-sql"
  end
end
