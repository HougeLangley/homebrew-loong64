class Fence < Formula
  desc "Lightweight sandbox for commands with network and filesystem restrictions"
  homepage "https://example.org/fence"
  version "0.1.67"
  url "http://127.0.0.1:8080/brew/bottles/fence--0.1.67.loongarch64.bottle.tar.gz"
  sha256 "542c07c46908692dc743a8d5059705619d25ffbd1f1cd87da51fc099efe6f75f"

  def install
    bin.install "fence"
  end

  test do
    system "#{bin}/fence"
  end
end
