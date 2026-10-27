class Prm < Formula
  desc "Pull Request Manager for Maintainers"
  homepage "https://example.org/prm"
  version "3.6.4"
  url "http://127.0.0.1:8080/brew/bottles/prm--3.6.4.loongarch64.bottle.tar.gz"
  sha256 "dcf7ae1e57e4d1581fc539c16d201c3e2ebb64e24eb4c9e3a181afb8f65d9c2d"

  def install
    bin.install "prm"
  end

  test do
    system "#{bin}/prm"
  end
end
