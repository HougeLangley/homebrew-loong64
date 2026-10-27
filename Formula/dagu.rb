class Dagu < Formula
  desc "Self-hostable workflow orchestrator for teams whose main work isn't orchestration. Declara"
  homepage "https://example.org/dagu"
  version "2.23.0"
  url "http://127.0.0.1:8080/brew/bottles/dagu--2.23.0.loongarch64.bottle.tar.gz"
  sha256 "3c722dbda4183f82e4bbee5fd790e531c1f27069ad61e4a492c588b6e8a9118d"

  def install
    bin.install "dagu"
  end

  test do
    system "#{bin}/dagu"
  end
end
