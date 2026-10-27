class Telegram-downloader < Formula
  desc "Telegram Messenger downloader/tools written in Golang"
  homepage "https://example.org/telegram-downloader"
  version "0.20.4"
  url "http://127.0.0.1:8080/brew/bottles/telegram-downloader--0.20.4.loongarch64.bottle.tar.gz"
  sha256 "39997c95ba24d7b11fa5c8e3fe225b7d3b6cc1ae2283984bb90329086b45c4a0"

  def install
    bin.install "telegram-downloader"
  end

  test do
    system "#{bin}/telegram-downloader"
  end
end
