class Gosint < Formula
  desc "OSINT Swiss Army Knife"
  homepage "https://example.org/gosint"
  version "0.5"
  url "http://127.0.0.1:8080/brew/bottles/gosint--0.5.loongarch64.bottle.tar.gz"
  sha256 "238a1029f766f18706fee824d1d44549be837a1d6493ef55063921bc6155ccdc"

  def install
    bin.install "gosint"
  end

  test do
    system "#{bin}/gosint"
  end
end
