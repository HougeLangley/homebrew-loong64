class Hexyl < Formula
  desc "Command-line hex viewer"
  homepage "https://example.org/hexyl"
  version "0.17.0"
  url "http://127.0.0.1:8080/brew/bottles/hexyl--0.17.0.loongarch64.bottle.tar.gz"
  sha256 "a545292847afe80b9cb810e18a8bf2aa467873feb4e970522839e486edf22c2d"

  def install
    bin.install "hexyl"
  end

  test do
    system "#{bin}/hexyl"
  end
end
