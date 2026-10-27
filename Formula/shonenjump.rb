class Shonenjump < Formula
  desc "A faster way to change directory and improve command line productivity."
  homepage "https://example.org/shonenjump"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/shonenjump--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "e294dc3a3174412139d9f6e2ae0585556dae47cacfede32c491d3cd8737aad69"

  def install
    bin.install "shonenjump"
  end

  test do
    system "#{bin}/shonenjump"
  end
end
