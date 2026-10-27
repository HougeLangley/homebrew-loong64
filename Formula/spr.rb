class Spr < Formula
  desc "Stacked Pull Requests on GitHub"
  homepage "https://example.org/spr"
  version "0.17.6"
  url "http://127.0.0.1:8080/brew/bottles/spr--0.17.6.loongarch64.bottle.tar.gz"
  sha256 "c2e30c2575abb041d17dd29b40a9a8597df1972d1d094066d2bab742b06870f7"

  def install
    bin.install "spr"
  end

  test do
    system "#{bin}/spr"
  end
end
