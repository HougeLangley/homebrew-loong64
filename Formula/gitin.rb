class Gitin < Formula
  desc "commit/branch/workdir explorer for git"
  homepage "https://example.org/gitin"
  version "0.3.0"
  url "http://127.0.0.1:8080/brew/bottles/gitin--0.3.0.loongarch64.bottle.tar.gz"
  sha256 "14f8b3d372112654cfd9abcfa4ad1958256b01ab0c74717b35afbdd6d0729726"

  def install
    bin.install "gitin"
  end

  test do
    system "#{bin}/gitin"
  end
end
