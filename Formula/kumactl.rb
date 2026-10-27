class Kumactl < Formula
  desc "Kuma control plane command-line utility"
  homepage "https://example.org/kumactl"
  version "3.0.0"
  url "http://127.0.0.1:8080/brew/bottles/kumactl--3.0.0.loongarch64.bottle.tar.gz"
  sha256 "0ada124dda292ffd47de63572d0e7ad9c653226f8e7f54de24523c5fb2d6932c"

  def install
    bin.install "kumactl"
  end

  test do
    system "#{bin}/kumactl"
  end
end
