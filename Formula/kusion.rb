class Kusion < Formula
  desc "Declarative Intent Driven Platform Orchestrator for Internal Developer Platform (IDP)."
  homepage "https://example.org/kusion"
  version "0.15.0"
  url "http://127.0.0.1:8080/brew/bottles/kusion--0.15.0.loongarch64.bottle.tar.gz"
  sha256 "a83f840dc26e7ffc2976bd02930af5af79634fb4b56564a877b978919308980d"

  def install
    bin.install "kusion"
  end

  test do
    system "#{bin}/kusion"
  end
end
