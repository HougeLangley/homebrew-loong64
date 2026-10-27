class Megacmd < Formula
  desc "Command-line client for mega.co.nz storage service"
  homepage "https://example.org/megacmd"
  version "0.016"
  url "http://127.0.0.1:8080/brew/bottles/megacmd--0.016.loongarch64.bottle.tar.gz"
  sha256 "d26f8258511277d95753a9ba6e22173d92f50772aec82e6cf2d99fd24a12e127"

  def install
    bin.install "megacmd"
  end

  test do
    system "#{bin}/megacmd"
  end
end
