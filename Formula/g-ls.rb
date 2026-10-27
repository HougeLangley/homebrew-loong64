class G-ls < Formula
  desc "Powerful and cross-platform ls"
  homepage "https://example.org/g-ls"
  version "0.31.2"
  url "http://127.0.0.1:8080/brew/bottles/g-ls--0.31.2.loongarch64.bottle.tar.gz"
  sha256 "05968cedc22c967832101c567b305067decd93b06d0b5ae7027e15bafe172ee4"

  def install
    bin.install "g-ls"
  end

  test do
    system "#{bin}/g-ls"
  end
end
