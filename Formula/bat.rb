class Bat < Formula
  desc "Clone of cat with syntax highlighting"
  homepage "https://example.org/bat"
  version "0.26.1"
  url "http://127.0.0.1:8080/brew/bottles/bat--0.26.1.loongarch64.bottle.tar.gz"
  sha256 "a652540e6b66385a2328ec32e589e1bd6107bd96fa7d555d763e39d45d246145"

  def install
    bin.install "bat"
  end

  test do
    system "#{bin}/bat"
  end
end
