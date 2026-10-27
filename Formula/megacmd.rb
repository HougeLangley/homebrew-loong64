class Megacmd < Formula
  desc "Command-line client for mega.co.nz storage service"
  homepage "https://example.org/megacmd"
  version "0.016"
  url "http://127.0.0.1:8080/brew/bottles/megacmd--0.016.loongarch64.bottle.tar.gz"
  sha256 "2d9ab43b8c9cc495ba7b63f4cead1214c036a5bd77a879e6040f39c9f917822d"

  def install
    bin.install "megacmd"
  end

  test do
    system "#{bin}/megacmd"
  end
end
