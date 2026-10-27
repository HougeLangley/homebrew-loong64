class Urlhunter < Formula
  desc "a recon tool that allows searching on URLs that are exposed via shortener services"
  homepage "https://example.org/urlhunter"
  version "0.2.0"
  url "http://127.0.0.1:8080/brew/bottles/urlhunter--0.2.0.loongarch64.bottle.tar.gz"
  sha256 "b3d1f708ae7015a71ceddfa2f809e4c9b8a4db41eecd78963649f3eb83ff03d4"

  def install
    bin.install "urlhunter"
  end

  test do
    system "#{bin}/urlhunter"
  end
end
