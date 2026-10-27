class Gopass < Formula
  desc "The slightly more awesome standard unix password manager for teams"
  homepage "https://example.org/gopass"
  version "1.17.4"
  url "http://127.0.0.1:8080/brew/bottles/gopass--1.17.4.loongarch64.bottle.tar.gz"
  sha256 "a1cefd39109356c290c5fe79628363aafeb6d814cb5dcc7d12782be5f93eeb33"

  def install
    bin.install "gopass"
  end

  test do
    system "#{bin}/gopass"
  end
end
