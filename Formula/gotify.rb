class Gotify < Formula
  desc "Command-line interface for pushing messages to gotify/server"
  homepage "https://example.org/gotify"
  version "2.4.0"
  url "http://127.0.0.1:8080/brew/bottles/gotify--2.4.0.loongarch64.bottle.tar.gz"
  sha256 "9e5c6ee31490d7c39041159f00607912dafb6b386c60fcabb7ed8d093d8c76a1"

  def install
    bin.install "gotify"
  end

  test do
    system "#{bin}/gotify"
  end
end
