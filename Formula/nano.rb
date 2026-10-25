class Nano < Formula
  desc "Small and friendly text editor"
  homepage "https://example.org/nano"
  version "9.3"
  url "http://127.0.0.1:8080/brew/bottles/nano--9.3.loongarch64.bottle.tar.gz"
  sha256 "dbd2a7d0d3b9360907f73fdc6d8896855205e4218e2b3228a971514f2e87b92b"

  def install
    bin.install "nano"
  end

  test do
    system "#{bin}/nano"
  end
end
