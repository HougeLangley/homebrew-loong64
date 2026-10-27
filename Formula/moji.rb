class Moji < Formula
  desc "find and download fonts from the terminal"
  homepage "https://example.org/moji"
  version "0.8.0"
  url "http://127.0.0.1:8080/brew/bottles/moji--0.8.0.loongarch64.bottle.tar.gz"
  sha256 "d2650d89ef6af28381873da5afa75d5d7811ff9a2f30196228b14495d9142f85"

  def install
    bin.install "moji"
  end

  test do
    system "#{bin}/moji"
  end
end
