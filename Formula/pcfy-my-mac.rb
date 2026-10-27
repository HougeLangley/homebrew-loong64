class Pcfy-my-mac < Formula
  desc "Get a PC-like (Windows/Linux) experience on macOS - PC-style keyboard shortcuts and window"
  homepage "https://example.org/pcfy-my-mac"
  version "0.2.6"
  url "http://127.0.0.1:8080/brew/bottles/pcfy-my-mac--0.2.6.loongarch64.bottle.tar.gz"
  sha256 "7dccd3a7125fd1e07d574e0c8ecf31c142af468d6f00ac442fa347b65bbb6f89"

  def install
    bin.install "pcfy-my-mac"
  end

  test do
    system "#{bin}/pcfy-my-mac"
  end
end
