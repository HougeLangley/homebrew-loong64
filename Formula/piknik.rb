class Piknik < Formula
  desc "Copy/paste anything over the network."
  homepage "https://example.org/piknik"
  version "0.10.2"
  url "http://127.0.0.1:8080/brew/bottles/piknik--0.10.2.loongarch64.bottle.tar.gz"
  sha256 "aed5e335700ade924b748268331ebeabd15da85dbde96c6013a1a9cbb5cc2e39"

  def install
    bin.install "piknik"
  end

  test do
    system "#{bin}/piknik"
  end
end
