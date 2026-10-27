class Bagel < Formula
  desc "CLI to audit posture and evaluate compromise blast radius"
  homepage "https://example.org/bagel"
  version "0.7.1"
  url "http://127.0.0.1:8080/brew/bottles/bagel--0.7.1.loongarch64.bottle.tar.gz"
  sha256 "7d86dc5d240ab032f9cb56d9d577ce1e08bde578fe9541056fd8e9e4596ee97a"

  def install
    bin.install "bagel"
  end

  test do
    system "#{bin}/bagel"
  end
end
