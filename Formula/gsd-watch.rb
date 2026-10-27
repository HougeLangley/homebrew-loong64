class Gsd-watch < Formula
  desc "🧠 Real-time dashboard for GSD + Claude Code workflows — track phases, tasks and progress a"
  homepage "https://example.org/gsd-watch"
  version "1.4.0"
  url "http://127.0.0.1:8080/brew/bottles/gsd-watch--1.4.0.loongarch64.bottle.tar.gz"
  sha256 "9dadd1b85df3848259a7a371bfef3dd814282bf7d9214b1f7fd086b7c591ba3e"

  def install
    bin.install "gsd-watch"
  end

  test do
    system "#{bin}/gsd-watch"
  end
end
