class Resto < Formula
  desc "🔗 Send pretty HTTP & API requests with TUI."
  homepage "https://example.org/resto"
  version "0.1.6"
  url "http://127.0.0.1:8080/brew/bottles/resto--0.1.6.loongarch64.bottle.tar.gz"
  sha256 "9633926632b6bede012cb2496743e696fee5b01e2e23075d79914eb070729b2f"

  def install
    bin.install "resto"
  end

  test do
    system "#{bin}/resto"
  end
end
