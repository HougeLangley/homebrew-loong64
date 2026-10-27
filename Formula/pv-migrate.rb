class Pv-migrate < Formula
  desc "CLI tool to migrate or backup/restore Kubernetes persistent volumes"
  homepage "https://example.org/pv-migrate"
  version "3.7.0"
  url "http://127.0.0.1:8080/brew/bottles/pv-migrate--3.7.0.loongarch64.bottle.tar.gz"
  sha256 "9e0976ee58b673ad13135f53afd7726e5b76d55c53e33de7841c243f590e65d1"

  def install
    bin.install "pv-migrate"
  end

  test do
    system "#{bin}/pv-migrate"
  end
end
