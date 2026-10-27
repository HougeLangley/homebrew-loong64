class Anubis < Formula
  desc "Weighs the soul of incoming HTTP requests to stop AI crawlers"
  homepage "https://example.org/anubis"
  version "1.28.2"
  url "http://127.0.0.1:8080/brew/bottles/anubis--1.28.2.loongarch64.bottle.tar.gz"
  sha256 "d2549ded6f669618060804afb6890b11bf55a36fe1f088ec694c50688a33371f"

  def install
    bin.install "anubis"
  end

  test do
    system "#{bin}/anubis"
  end
end
