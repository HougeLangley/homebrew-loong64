class Oasis < Formula
  desc "CLI for interacting with the Oasis Protocol network"
  homepage "https://example.org/oasis"
  version "0.22.1"
  url "http://127.0.0.1:8080/brew/bottles/oasis--0.22.1.loongarch64.bottle.tar.gz"
  sha256 "bf774be80493e1b6d2c443e5f2b0b364e98dcd91753cee31d53a3de346486b4d"

  def install
    bin.install "oasis"
  end

  test do
    system "#{bin}/oasis"
  end
end
