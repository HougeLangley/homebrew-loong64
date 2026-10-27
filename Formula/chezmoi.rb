class Chezmoi < Formula
  desc "Manage your dotfiles across multiple diverse machines, securely."
  homepage "https://example.org/chezmoi"
  version "2.73.3"
  url "http://127.0.0.1:8080/brew/bottles/chezmoi--2.73.3.loongarch64.bottle.tar.gz"
  sha256 "2f18bb9ef675d7b1cfd77acb0458869d2418dde3f588a757f408f5f7c0559d8e"

  def install
    bin.install "chezmoi"
  end

  test do
    system "#{bin}/chezmoi"
  end
end
