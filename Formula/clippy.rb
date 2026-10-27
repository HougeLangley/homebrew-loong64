class Clippy < Formula
  desc "Copy files from your terminal that actually paste into GUI apps"
  homepage "https://example.org/clippy"
  version "1.9.1"
  url "http://127.0.0.1:8080/brew/bottles/clippy--1.9.1.loongarch64.bottle.tar.gz"
  sha256 "334f1e9bfb893d3491988e95421124c9e038bd8337c478e79ed00acfa49b731a"

  def install
    bin.install "clippy"
  end

  test do
    system "#{bin}/clippy"
  end
end
