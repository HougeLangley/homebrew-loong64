class Lockenv < Formula
  desc "Simple, password-based encrypted vault for .env and infrastructure secrets. Like git-crypt"
  homepage "https://example.org/lockenv"
  version "0.1.8"
  url "http://127.0.0.1:8080/brew/bottles/lockenv--0.1.8.loongarch64.bottle.tar.gz"
  sha256 "ab0c0c9fa78cc53581acbec22064595b407ea6c9768ef683edbbabc5b443139d"

  def install
    bin.install "lockenv"
  end

  test do
    system "#{bin}/lockenv"
  end
end
