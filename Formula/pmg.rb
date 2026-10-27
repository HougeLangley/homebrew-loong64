class Pmg < Formula
  desc "PMG protects developers, AI agents from malicious open source packages using proxy, sandbo"
  homepage "https://example.org/pmg"
  version "0.33.0"
  url "http://127.0.0.1:8080/brew/bottles/pmg--0.33.0.loongarch64.bottle.tar.gz"
  sha256 "00ca7b7cc16e56a9d7a016c44709922ac331a3d97886e548a1c081858f793e53"

  def install
    bin.install "pmg"
  end

  test do
    system "#{bin}/pmg"
  end
end
