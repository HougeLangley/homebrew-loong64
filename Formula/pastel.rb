class Pastel < Formula
  desc "Command-line color manipulation tool"
  homepage "https://example.org/pastel"
  version "0.12.0"
  url "http://127.0.0.1:8080/brew/bottles/pastel--0.12.0.loongarch64.bottle.tar.gz"
  sha256 "e82729926afea291550b8c4762eb390f14f1446d8762090c7e6be2ffaa65fcef"

  def install
    bin.install "pastel"
  end

  test do
    system "#{bin}/pastel"
  end
end
