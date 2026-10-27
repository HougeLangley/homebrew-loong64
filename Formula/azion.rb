class Azion < Formula
  desc "CLI for the Azion service"
  homepage "https://example.org/azion"
  version "4.24.0-dev.20"
  url "http://127.0.0.1:8080/brew/bottles/azion--4.24.0-dev.20.loongarch64.bottle.tar.gz"
  sha256 "8b6520dcf9d8b65e20c6c21229b98bed2b4bba8e6c14147fff32244cb7857ae9"

  def install
    bin.install "azion"
  end

  test do
    system "#{bin}/azion"
  end
end
