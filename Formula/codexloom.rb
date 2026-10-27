class Codexloom < Formula
  desc "Turn Codex threads into an organization of long-lived domain agents."
  homepage "https://example.org/codexloom"
  version "0.1.0-dev.1"
  url "http://127.0.0.1:8080/brew/bottles/codexloom--0.1.0-dev.1.loongarch64.bottle.tar.gz"
  sha256 "559c752a2a057c5309684b2ed03d72cdc775ad9c1228f50b3e6c84a83e9be3c9"

  def install
    bin.install "codexloom"
  end

  test do
    system "#{bin}/codexloom"
  end
end
