class Smug < Formula
  desc "Automate your tmux workflow"
  homepage "https://example.org/smug"
  version "0.3.19"
  url "http://127.0.0.1:8080/brew/bottles/smug--0.3.19.loongarch64.bottle.tar.gz"
  sha256 "dfb714869491d0e1f9e8ef3692448ba75d656f0df0e635db0b2bce0449f0d8bf"

  def install
    bin.install "smug"
  end

  test do
    system "#{bin}/smug"
  end
end
