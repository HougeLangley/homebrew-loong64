class Claude-gym < Formula
  desc "A pixel-art exercise companion that nudges you to move during long Claude Code runs"
  homepage "https://example.org/claude-gym"
  version "0.1.1"
  url "http://127.0.0.1:8080/brew/bottles/claude-gym--0.1.1.loongarch64.bottle.tar.gz"
  sha256 "a04ff35f33015108a5e1aaa63411682842946986d386b841dd67251a98d944e8"

  def install
    bin.install "claude-gym"
  end

  test do
    system "#{bin}/claude-gym"
  end
end
