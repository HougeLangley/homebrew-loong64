class Rat < Formula
  desc "Compose shell commands to build interactive terminal applications"
  homepage "https://example.org/rat"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/rat--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "d1eac80c240708831b060d4a8a1461265182b7104a5619632e732eee1fa3dfb6"

  def install
    bin.install "rat"
  end

  test do
    system "#{bin}/rat"
  end
end
