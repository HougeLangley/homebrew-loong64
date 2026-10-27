class Kpt < Formula
  desc "Automate Kubernetes Configuration Editing"
  homepage "https://example.org/kpt"
  version "1.0.1"
  url "http://127.0.0.1:8080/brew/bottles/kpt--1.0.1.loongarch64.bottle.tar.gz"
  sha256 "2b0e8611359e355a4760cb8bf20ed9a8191405095a89957739c4f84e93ca0cae"

  def install
    bin.install "kpt"
  end

  test do
    system "#{bin}/kpt"
  end
end
