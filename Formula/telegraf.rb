class Telegraf < Formula
  desc "Plugin-driven server agent for collecting & reporting metrics"
  homepage "https://example.org/telegraf"
  version "1.40.2"
  url "http://127.0.0.1:8080/brew/bottles/telegraf--1.40.2.loongarch64.bottle.tar.gz"
  sha256 "7e7bd06c158582603b0ee06345e0bc3890ac50cbab19b0434f83f2edb4128cab"

  def install
    bin.install "telegraf"
  end

  test do
    system "#{bin}/telegraf"
  end
end
