class Desk-buddy < Formula
  desc "Turn an old jailbroken Kindle Paperwhite into a calm desk companion: tasks, calendar, weat"
  homepage "https://example.org/desk-buddy"
  version "1.2"
  url "http://127.0.0.1:8080/brew/bottles/desk-buddy--1.2.loongarch64.bottle.tar.gz"
  sha256 "194537f327cc5e92f2484fef086515bd4a75bf7cf518a302009da7deb58333fb"

  def install
    bin.install "desk-buddy"
  end

  test do
    system "#{bin}/desk-buddy"
  end
end
