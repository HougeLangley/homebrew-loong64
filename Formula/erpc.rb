class Erpc < Formula
  desc "Fault-tolerant RPC proxy with re-org-aware permanent caching"
  homepage "https://example.org/erpc"
  version "0.4.0"
  url "http://127.0.0.1:8080/brew/bottles/erpc--0.4.0.loongarch64.bottle.tar.gz"
  sha256 "5bb8f751e406ff259f44df1336ded852fe7e800432b13e903bdd10a356b89325"

  def install
    bin.install "erpc"
  end

  test do
    system "#{bin}/erpc"
  end
end
