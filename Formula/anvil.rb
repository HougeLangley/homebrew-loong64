class Anvil < Formula
  desc "CLI to streamline config management and tool installation. Install your full dev tool-chai"
  homepage "https://example.org/anvil"
  version "2.9.0"
  url "http://127.0.0.1:8080/brew/bottles/anvil--2.9.0.loongarch64.bottle.tar.gz"
  sha256 "f29ab1c9e2fdc7142e2640240d92aec37ef3a4d9ff5763cfcdef75869e889e30"

  def install
    bin.install "anvil"
  end

  test do
    system "#{bin}/anvil"
  end
end
