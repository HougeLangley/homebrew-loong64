class K9s < Formula
  desc "Kubernetes CLI UI"
  homepage "https://example.org/k9s"
  version "0.51.0"
  url "http://127.0.0.1:8080/brew/bottles/k9s--0.51.0.loongarch64.bottle.tar.gz"
  sha256 "2bd6dfddbd8d033caf9ba241909c64c55525dcd9515b8710ce6c8407de7465f9"

  def install
    bin.install "k9s"
  end

  test do
    system "#{bin}/k9s"
  end
end
