class Froggit < Formula
  desc "Simplify your Git workflow with visual feedback, keyboard-driven controls, and a streamlin"
  homepage "https://example.org/froggit"
  version "1.4.0-beta"
  url "http://127.0.0.1:8080/brew/bottles/froggit--1.4.0-beta.loongarch64.bottle.tar.gz"
  sha256 "1580fe9dbaa26fc1fe76ed6fe453215ed80f9bee3b3a2d87d31ab1a9bc33f67f"

  def install
    bin.install "froggit"
  end

  test do
    system "#{bin}/froggit"
  end
end
