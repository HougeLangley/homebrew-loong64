class Rote < Formula
  desc "A cron that remembers what it did — a CLI job scheduler with persistent run history, captu"
  homepage "https://example.org/rote"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/rote--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "9c541a6f7096a069b2dae94af9fc49324b7b9aaffb761b26254deae0bdafd289"

  def install
    bin.install "rote"
  end

  test do
    system "#{bin}/rote"
  end
end
