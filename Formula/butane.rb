class Butane < Formula
  desc "Translates human-readable Butane Configs into machine-readable Ignition Configs"
  homepage "https://example.org/butane"
  version "0.29.0"
  url "http://127.0.0.1:8080/brew/bottles/butane--0.29.0.loongarch64.bottle.tar.gz"
  sha256 "8c0ce98ce19c0baa957c6e73ff5653d4d6e158e17cb16587f9516433687b4f2b"

  def install
    bin.install "butane"
  end

  test do
    system "#{bin}/butane"
  end
end
