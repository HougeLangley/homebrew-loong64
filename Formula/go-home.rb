class Go-home < Formula
  desc "An OpenGL based progress bar that lets you know when you should really go home after a lon"
  homepage "https://example.org/go-home"
  version "1.1.1"
  url "http://127.0.0.1:8080/brew/bottles/go-home--1.1.1.loongarch64.bottle.tar.gz"
  sha256 "02f21b260a273c3e32dd91aa51edd3df5f75b262f6003a55217041d18d401199"

  def install
    bin.install "go-home"
  end

  test do
    system "#{bin}/go-home"
  end
end
