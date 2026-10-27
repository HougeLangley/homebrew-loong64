class Sidekick < Formula
  desc "Deploy applications to your VPS"
  homepage "https://example.org/sidekick"
  version "0.6.6"
  url "http://127.0.0.1:8080/brew/bottles/sidekick--0.6.6.loongarch64.bottle.tar.gz"
  sha256 "bb84c4b2f1429d551ef9d19b97145c42b887ae03ee62e34cbae332ae0ef65801"

  def install
    bin.install "sidekick"
  end

  test do
    system "#{bin}/sidekick"
  end
end
