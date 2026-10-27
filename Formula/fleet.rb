class Fleet < Formula
  desc "Open device management"
  homepage "https://example.org/fleet"
  version "fleet-v4.93.2"
  url "http://127.0.0.1:8080/brew/bottles/fleet--fleet-v4.93.2.loongarch64.bottle.tar.gz"
  sha256 "54cd1589520a122bf20dad935a7bb2cb54f5fa5bd7dce414d420bd6231088711"

  def install
    bin.install "fleet"
  end

  test do
    system "#{bin}/fleet"
  end
end
