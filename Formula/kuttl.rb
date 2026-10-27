class Kuttl < Formula
  desc "KUbernetes Test TooL"
  homepage "https://example.org/kuttl"
  version "0.28.0"
  url "http://127.0.0.1:8080/brew/bottles/kuttl--0.28.0.loongarch64.bottle.tar.gz"
  sha256 "ea61544e09abed8832868e63e6046dc2f06c24ee1baab19dcec0b38b090de7b5"

  def install
    bin.install "kuttl"
  end

  test do
    system "#{bin}/kuttl"
  end
end
