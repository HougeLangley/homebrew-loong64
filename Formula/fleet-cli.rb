class Fleet-cli < Formula
  desc "Manage large fleets of Kubernetes clusters"
  homepage "https://example.org/fleet-cli"
  version "0.16.3"
  url "http://127.0.0.1:8080/brew/bottles/fleet-cli--0.16.3.loongarch64.bottle.tar.gz"
  sha256 "653dc73005576b7fbefce574c76e8bf92aac3035ff8edf1523b22b657b4557aa"

  def install
    bin.install "fleet-cli"
  end

  test do
    system "#{bin}/fleet-cli"
  end
end
