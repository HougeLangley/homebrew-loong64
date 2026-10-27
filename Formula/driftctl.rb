class Driftctl < Formula
  desc "Detect, track and alert on infrastructure drift"
  homepage "https://example.org/driftctl"
  version "0.40.0"
  url "http://127.0.0.1:8080/brew/bottles/driftctl--0.40.0.loongarch64.bottle.tar.gz"
  sha256 "91426dc91e6460268bd0549ccc2277501d160e7f787aafd9a72c7981245e2322"

  def install
    bin.install "driftctl"
  end

  test do
    system "#{bin}/driftctl"
  end
end
