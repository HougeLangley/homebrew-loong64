class Maintenant < Formula
  desc "Self-hosted monitoring for Docker, Kubernetes and uptime. Single Go binary, no agent confi"
  homepage "https://example.org/maintenant"
  version "1.11.0"
  url "http://127.0.0.1:8080/brew/bottles/maintenant--1.11.0.loongarch64.bottle.tar.gz"
  sha256 "130c8fd42320df206e043a77c0e759ae31970574f257b635e06a515539be6e04"

  def install
    bin.install "maintenant"
  end

  test do
    system "#{bin}/maintenant"
  end
end
