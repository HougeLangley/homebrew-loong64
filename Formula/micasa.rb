class Micasa < Formula
  desc "TUI for tracking home projects, maintenance schedules, appliances and quotes"
  homepage "https://example.org/micasa"
  version "2.8.2"
  url "http://127.0.0.1:8080/brew/bottles/micasa--2.8.2.loongarch64.bottle.tar.gz"
  sha256 "b80527f8b6cbd798d8324f625899f18cf3f77c1c4df9e363ba4660c2aa936325"

  def install
    bin.install "micasa"
  end

  test do
    system "#{bin}/micasa"
  end
end
