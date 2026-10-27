class Goat < Formula
  desc "General purpose AT Protocol CLI in Go"
  homepage "https://example.org/goat"
  version "0.2.8"
  url "http://127.0.0.1:8080/brew/bottles/goat--0.2.8.loongarch64.bottle.tar.gz"
  sha256 "9cc08811e6cadf08dc0825cd28d91ec0910cb773a160a75ce2aadee27eed5911"

  def install
    bin.install "goat"
  end

  test do
    system "#{bin}/goat"
  end
end
