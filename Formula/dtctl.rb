class Dtctl < Formula
  desc "CLI for managing Dynatrace platform resources - built for humans and AI agents"
  homepage "https://example.org/dtctl"
  version "0.45.0"
  url "http://127.0.0.1:8080/brew/bottles/dtctl--0.45.0.loongarch64.bottle.tar.gz"
  sha256 "bfd836c298513139a0e2832b1228d083c37d4841b47b41d5cf1c5aa8a065617b"

  def install
    bin.install "dtctl"
  end

  test do
    system "#{bin}/dtctl"
  end
end
