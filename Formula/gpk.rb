class Gpk < Formula
  desc "TUI and CLI that unifies every package manager on the system"
  homepage "https://example.org/gpk"
  version "0.6.10"
  url "http://127.0.0.1:8080/brew/bottles/gpk--0.6.10.loongarch64.bottle.tar.gz"
  sha256 "3097013f6e1410b84a32703a473c26d7a61a3cd0f9fc7f958636f9b1451a1345"

  def install
    bin.install "gpk"
  end

  test do
    system "#{bin}/gpk"
  end
end
